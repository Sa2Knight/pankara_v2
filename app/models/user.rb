class User < ApplicationRecord
  has_secure_password
  has_many :user_events
  has_many :events, through: :user_events
  has_many :own_events, class_name: 'Event', dependent: :nullify

  def self.from_token_request(request)
    User.first
  end

  #
  # 歌唱履歴一覧
  #
  def histories
    History.where(user_event: self.user_events)
  end
end
