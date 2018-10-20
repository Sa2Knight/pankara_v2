#
# 【楽曲の歌唱回数】song:#{id}:histories_count:#{user|all}
#   History(CUD)
# 【歌手の歌手回数】artist#{id}:histories_count:#{user|all}
#   History(CUD)
#
module RedisClient
  module_function

  # 強制的に再計算させる場合にtrueにする
  @active = true

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
    return value if Rails.env.test?

    redis.set(key, value)
    value
  end

  #
  # Redisからデータを取得する
  #
  def get(key:, type: Integer)
    return nil if Rails.env.test?
    return nil unless @active

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

  #
  # キャッシュを利用可能状態にする
  #
  def activate
    @active = true
  end

  #
  # キャッシュを利用不可状態にする
  #
  def inactivate
    @active = false
  end
end
