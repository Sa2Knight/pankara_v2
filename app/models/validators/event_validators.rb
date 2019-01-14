class EventValidators < ActiveModel::Validator
  def validate(record)
    @record = record

    if date_blank?
      record.errors[:date] << '日付は必須です'
    elsif date_invalid?
      record.errors[:date] << '日付が不正な文字列です'
    elsif date_future?
      record.errors[:date] << '未来の日付は設定できません'
    end
  end

  private

  def date_blank?
    @record.date.blank?
  end

  def date_invalid?
    Date.valid_by?(@record.date.to_s).blank?
  end

  def date_future?
    Date.parse(@record.date.to_s).future?
  end
end
