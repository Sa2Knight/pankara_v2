class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  #
  # マージしたエラーメッセージ
  #
  def full_error_message
    return nil if self.errors.blank?
    self.errors.messages.values.join("\n")
  end
end
