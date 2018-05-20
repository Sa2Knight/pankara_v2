module JSON
  module Song
    #
    # Songモデルの属性のみ
    #
    def self.raw(song)
      return nil if song.blank?
      {
        id: song.id,
        artist_id: song.artist_id,
        name: song.name,
        url: song.url
      }
    end

    #
    # 一覧取得用(歌手情報付き)
    #
    def self.index_with_artist(song)
      return nil if song.blank?

      self.raw(song).merge(
        artist: JSON::Artist.raw(song.artist)
      )
    end

    #
    # 詳細取得用
    #
    def self.show(song, user = nil)
      return nil if song.blank?

      self.index_with_artist(song).merge(
        my_histories_count: song.histories_count_by(user: user),
        histories_count: song.histories_count
      )
    end
  end
end
