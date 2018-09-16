class Artist < ApplicationRecord
  has_many :songs, dependent: :destroy

  scope :no_descriptions, -> { where(description: nil).or(where(url: nil)) }

  #
  # 歌唱履歴
  # NOTE: has_manyだけで表現できる?
  #
  def histories
    History.where(song_id: self.songs.ids)
  end
end
