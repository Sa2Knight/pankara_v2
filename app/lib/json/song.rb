module JSON
  module Song
    #
    # Songモデルの属性のみ
    #
    def self.raw(song, user: nil)
      return nil if song.blank?
      {
        id: song.id,
        artist_id: song.artist_id,
        name: song.name,
        url: song.url,
        histories_count: song.histories_count,
        histories_count_by_me: user ? song.histories_count_by(user: user) : 0
      }
    end

    #
    # 一覧取得用(歌手情報付き)
    #
    def self.raw_with_artist(song, user: nil)
      return nil if song.blank?
      self.raw(song, user: user).merge(
        artist: JSON::Artist.raw(song.artist)
      )
    end

    #
    # 詳細取得用
    #
    def self.show(song, user = nil)
      return nil if song.blank?

      self.raw_with_artist(song).merge(
        my_histories_count: song.histories_count_by(user: user),
        histories_count: song.histories_count
      )
    end
  end
end
