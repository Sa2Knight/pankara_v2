module JSON
  module Song
    def self.generate(song)
      return nil if song.blank?
      {
        id: song.id,
        artist_id: song.artist_id,
        name: song.name,
        url: song.url
      }
    end

    def self.generate_with_artist(song)
      return nil if song.blank?
      self.generate(song).merge(artist: JSON::Artist.generate(song.artist))
    end
  end
end
