# 共通エラー処理
module Authentications
  extend ActiveSupport::Concern

  def logged_in_or_401
    raise401 if current_user.blank?
  end
end
