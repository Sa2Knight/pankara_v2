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

  #
  # 特定ユーザの歌唱履歴
  #
  def histories_by(user: nil)
    return none if user.blank?
    self.histories.includes(:user).where(user_event: user.user_events)
  end

  #
  # 歌唱回数
  #
  def histories_count
    RedisClient.get_or_set(key: redis_histories_count_key('all')) do
      self.histories.size
    end
  end

  #
  # 特定ユーザの歌唱回数
  #
  def histories_count_by(user:)
    RedisClient.get_or_set(key: redis_histories_count_key(user.id)) do
      self.histories_by(user: user).size
    end
  end

  #
  # 歌唱回数記録用のRedisキー
  #
  def redis_histories_count_key(user_id)
    "artist:#{self.id}:histories_count#{user_id}"
  end
end
