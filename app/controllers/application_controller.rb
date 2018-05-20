class ApplicationController < ActionController::Base
  before_action :check_session

  #
  # セッションをチェックしログインユーザを取得
  # TODO: ログインの仕組み作って差し替え
  #
  def check_session
    @current_user = User.first
  end
end
