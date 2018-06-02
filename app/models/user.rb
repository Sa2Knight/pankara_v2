class User < ApplicationRecord
  has_many :user_events
  has_many :events, through: :user_events

  #
  # パスワード代入時にハッシュ化する
  #
  def password=(new_password)
    self.hashed_password = Digest::SHA2.new(512).hexdigest(new_password)
  end
end
