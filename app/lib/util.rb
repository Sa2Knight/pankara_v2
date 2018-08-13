module Util
  module_function

  #
  # 指定した日付時刻間のランダムな日付時刻を戻す
  #
  def random_datetime(from: nil, to: nil)
    from ||= Time.zone.parse('2015/01/01 00:00:00')
    to   ||= Time.zone.now
    from < to ? Random.rand(from..to) : Time.zone.now
  end

  def number_key_hash_to_array(hash, max: 10, offset: 0, default: nil)
    (0..max).reduce([]) do |ac, n|
      ac[n] = hash[n + offset].presence || default
      ac
    end
  end
end
