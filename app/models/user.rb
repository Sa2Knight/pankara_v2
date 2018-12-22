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

  #
  # 友達一覧
  # Note: 現在はみんな友だち。いずれフレンド機能を実装する
  #
  def friends
    User.where.not(id: self.id)
  end

  #
  # 指定したIDのユーザが全て友達か？
  #
  def friend_all?(user_ids)
    return true if Array(user_ids).blank?
    self.friends.where(id: user_ids).size == user_ids.size
  end
end
