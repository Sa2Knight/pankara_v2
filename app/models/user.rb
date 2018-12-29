class User < ApplicationRecord
  has_secure_password
  has_many :user_events, dependent: :destroy
  has_many :events, through: :user_events
  has_many :own_events, class_name: 'Event', dependent: :nullify

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
  # 持ち歌一覧
  # 一度以上歌ったことのある楽曲のIDリストを戻す
  # 結果は全てRedisにキャッシュされる
  #
  def my_song_ids
    RedisClient.get_or_set(key: "user_#{self.id}_song_list", type: Array) do
      self.histories.pluck(:song_id).uniq
    end
  end

  #
  # 指定したIDのユーザが全て友達か？
  #
  def friend_all?(user_ids)
    return true if Array(user_ids).blank?
    self.friends.where(id: user_ids).size == user_ids.size
  end
end
