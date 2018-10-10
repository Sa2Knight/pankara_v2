#
# 歌唱履歴一覧を持っているモデル共通のモジュール
#
module CountableHistories
  #
  # 歌唱履歴一覧を取得する
  #
  def histories
    raise NotImplementedError
  end

  #
  # 特定ユーザの歌唱履歴一覧を取得する
  #
  def histories_by
    raise NotImplementedError
  end

  #
  # 歌唱回数記録用のRedisキー
  #
  def redis_histories_count_key(*)
    raise NotImplementedError
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
end
