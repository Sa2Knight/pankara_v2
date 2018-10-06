namespace :redis do
  desc '歌唱回数を全て再キャッシュ'

  task make_all_histories_count_cache: :environment do
    # Redisキャッシュ機能を無効にして、既にキャッシュ済みのも再計算させる
    RedisClient.inactivate

    # 各楽曲の総歌唱回数を再計算
    Song.all.each(&:histories_count)

    # 楽曲とユーザの組み合わせを総なめして歌唱回数を再計算
    user_song_hash = History.includes(:user).map do |history|
      [
        history.song,
        history.user
      ]
    end
    user_song_hash.uniq.each do |song, user|
      song.histories_count_by(user: user)
    end

    # あんまり意味ないけど一応戻しておく
    RedisClient.activate
  end
end
