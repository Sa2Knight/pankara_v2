module RedisClient
  module_function

  #
  # Redisクライアント本体
  #
  def redis
    @redis ||= Redis.new(host: 'pankara_redis', port: 6379)
  end

  #
  # Redisにデータをセットする
  #
  def set(key:, value:)
    redis.set(key, value)
  end

  #
  # Redisからデータを取得する
  #
  def get(key:)
    redis.get(key)
  end

end
