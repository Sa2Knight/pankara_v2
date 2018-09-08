module JSON
  module Artist
    module_function

    #
    # 詳細取得用
    #
    def show(artist)
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
