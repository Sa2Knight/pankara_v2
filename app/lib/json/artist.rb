module JSON
  module Artist
    module_function

    #
    # 生データ
    #
    def raw(artist)
      return nil if artist.blank?
      {
        id: artist.id,
        name: artist.name,
        description: artist.description,
        url: artist.url,
      }
    end

    #
    # 詳細取得用
    # TODO: songsは別APIにしても良いのでは
    #
    def show(artist)
      return nil if artist.blank?
      raw(artist).merge(
        songs: artist.songs.map do |song|
          JSON::Song.raw(song)
        end
      )
    end

  end
end
