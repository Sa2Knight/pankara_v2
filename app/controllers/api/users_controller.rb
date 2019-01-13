class Api::UsersController < Api::BaseController
  before_action :authorized?, only: :myself
  before_action :user_present_or_404, only: %i[show my_songs]

  #
  # ログイン中の自身の情報を取得
  #
  def myself
    render json: JSON::User.raw(current_user)
  end

  #
  # ユーザの詳細を取得
  #
  def show
    render json: JSON::User.raw(user)
  end

  private

  #
  # 対象ユーザ
  #
  def user
    @user ||= User.find_by(id: params[:id])
  end

  #
  # 詳細取得対象ユーザが存在するか?
  #
  def user_present_or_404
    raise404 'user_not_found' if user.blank?
  end
end
