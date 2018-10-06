#
# 【楽曲の歌唱履歴】song:#{id}:histories_count:#{user|all}
#   History(CUD)
#
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
    value
  end

  #
  # Redisからデータを取得する
  #
  def get(key:, type: Integer)
    result = redis.get(key)
    return nil if result.nil?

    return result.to_i if type == Integer
    return JSON.parse(result) if type.in? [Array, Hash]

    result
  end

  #
  # Redisから全データを破棄する
  #
  def flush_all
    redis.flushall
  end

  #
  # Redisからデータを取得するが、ない場合新たに生成する
  #
  def get_or_set(key:, type: Integer, &_block)
    result = get(key: key, type: type)
    return result if result

    set(key: key, value: yield)
  end
end
