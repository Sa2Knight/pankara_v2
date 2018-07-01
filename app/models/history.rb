class History < ApplicationRecord
  belongs_to :user_event
  belongs_to :song
  belongs_to :score_type, optional: true

  has_one :user,   through: :user_event
  has_one :event,  through: :user_event
  has_one :artist, through: :song

  scope :by_user_event, lambda { |user_event|
    user_event.present? ? where(user_event: user_event) : self
  }
end
