module JSON
  module Artist
    def self.generate(artist)
      return nil if artist.blank?
      {
        id: artist.id,
        name: artist.name
      }
    end
  end
end
