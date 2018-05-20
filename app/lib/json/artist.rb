module JSON
  module Artist
    #
    # Artistモデルの属性のみ
    #
    def self.raw(artist)
      return nil if artist.blank?
      {
        id: artist.id,
        name: artist.name
      }
    end
  end
end
