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
      User.create(
        id: user[:id],
        name: user[:username],
        display_name: user[:screenname],
        password: user[:username],
        image_url: "/user_icon/#{user[:username]}.png"
      )
    end

    # 楽曲と歌手を登録する
    dump[:songs].each do |song|
      Song.create(
        id: song[:song_id],
        name: song[:song_name],
        artist_name: song[:artist_name],
        url: song[:song_url]
      )
    end

    # イベントを登録する
    dump[:events].each do |event|
      Event.create(
        id: event[:id],
        title: event[:name],
        datetime: event[:datetime], # TODO: dateに変更
        # created_by: event[:created_by] TODO: 追加
      )
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
    dump[:histories].each do |history|
      History.create(
        id: history[:history_id],
        song_id: history[:song_id],
        user_event: UserEvent.find_or_create_by(
          user_id: history[:user_id], event_id: history[:karaoke_id]
        ),
        score: history[:score],
        score_type: score_type_map[history[:score_type]],
        satisfaction: history[:satisfaction],
        key: history[:song_key]
      )
    end

    # History.event_date 取得
    Rake::Task['histories:sync_history_event_date'].invoke

    # TODO: Artist.description取得
  end
end
