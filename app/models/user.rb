class User < ApplicationRecord
  has_secure_password
  has_many :user_events
  has_many :events, through: :user_events

  def self.from_token_request(request)
    User.first
  end
end
