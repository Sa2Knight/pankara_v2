require 'net/http'
namespace :common do
  desc '旧パンカラとデータを同期する'

  task sync_old_pankara_db: :environment do
    dump = JSON.parse(Net::HTTP.get(URI.parse(ENV['DUMP_URL'])))
               .deep_symbolize_keys

    # 実行前にDBとキャッシュをリセット
    Rake::Task['db:reset'].invoke
    RedisClient.redis.flushall

    # ユーザを作成する
    # 初期パスワードはユーザ名で設定
    # 画像URLはユーザ名.pngで固定
    dump[:users].each do |user|
      User.create!(
        id: user[:id],
        name: user[:username],
        display_name: user[:screenname],
        password: user[:username],
        image_url: "/user_icon/#{user[:username]}.png"
      )
    end

    # 楽曲と歌手を登録する
    dump[:songs].each do |song|
      Song.create!(
        id: song[:song_id],
        name: song[:song_name],
        artist_name: song[:artist_name],
        url: song[:song_url]
      )
    end

    # イベントを登録する
    dump[:events].each do |event|
      e = Event.create!(
        id: event[:id],
        title: event[:name],
        date: event[:datetime],
        user_id: 1 # この数値は後で書き換える
      )
      e.user_events.first.destroy
    end

    # 歌唱履歴を登録する
    score_type_map = {
      1 => 1, # JOY 全国
      2 => 2, # JOY 分析
      3 => 5, # JOYその他 to その他
      4 => 3, # DAM ランキング
      5 => 4, # DAM 精密
      6 => 5, # DAMその他 to その他
      7 => 6  # その他
    }
    user_event_hash = {}
    dump[:histories].each do |history|
      user_event_key = "#{history[:user_id]}_#{history[:karaoke_id]}"
      user_event = if user_event_hash.key?(user_event_key)
                     user_event_hash[user_event_key]
                   else
                     ue = UserEvent.create(
                       user_id: history[:user_id],
                       event_id: history[:karaoke_id]
                     )
                    user_event_hash[user_event_key] = ue
                   end

      History.create!(
        id: history[:history_id],
        song_id: history[:song_id],
        user_event: user_event,
        score: history[:score],
        score_type: score_type_map[history[:score_type]],
        satisfaction: history[:satisfaction],
        key: history[:song_key]
      )
    end

    # Event.user_idの設定
    Event.includes(:user_events).each do |e|
      e.update!(user_id: e.user_events.first.user_id)
    end

    # History.event_date 取得
    Rake::Task['histories:sync_history_event_date'].invoke

    # Artist.description取得
    # 重いので基本的にやらない
    # Rake::Task['artists:fetch_wikipedia_summary'].invoke
  end
end
