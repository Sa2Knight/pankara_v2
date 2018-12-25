class EventValidator < ActiveModel::Validator
  def validate(record)
    @record = record

    if datetime_blank?
      record.errors[:datetime] << '日付は必須です'
    elsif datetime_invalid?
      record.errors[:datetime] << '日付が不正な文字列です'
    elsif datetime_future?
      record.errors[:datetime] << '未来の日付は設定できません'
    end
  end

  private

  def datetime_blank?
    @record.datetime.blank?
  end

  def datetime_invalid?
    Date.valid_by?(@record.datetime.to_s).blank?
  end

  def datetime_future?
    Date.parse(@record.datetime.to_s).future?
  end
end
