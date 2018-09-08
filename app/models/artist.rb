class Artist < ApplicationRecord
  has_many :songs, dependent: :destroy

  scope :no_descriptions, -> { where(description: nil).or(where(url: nil)) }
end
