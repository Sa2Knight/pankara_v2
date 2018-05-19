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
end
