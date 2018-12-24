# Dateクラスの拡張
class Date
  #
  # 指定した文字列が日付として有効か？
  #
  def self.valid_by?(str)
    Date._parse(str).present?
  end
end
