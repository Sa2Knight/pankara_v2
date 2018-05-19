class Song < ApplicationRecord
  belongs_to :artist

  #
  # ArtistIDで絞り込み
  #
  def self.artist_by(artist_id)
    return self.all if artist_id.blank?
    self.where(artist_id: artist_id)
  end

  #
  # キーワードで絞り込み
  #
  def self.name_by(keyword)
    return self.all if keyword.blank?
    self.where("name like '%#{keyword}%'")
  end
end
