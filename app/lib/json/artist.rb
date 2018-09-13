module JSON
  module Artist
    module_function

    #
    # 詳細取得用
    #
    def raw(artist)
      return nil if artist.blank?
      {
        id: artist.id,
        name: artist.name,
        description: artist.description,
        url: artist.url
      }
    end
  end
end
