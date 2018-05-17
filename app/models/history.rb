class History < ApplicationRecord
  belongs_to :user_event
  belongs_to :song
  belongs_to :score_type, optional: true

  has_one :user,   through: :user_event
  has_one :event,  through: :user_event
  has_one :artist, through: :song
end
