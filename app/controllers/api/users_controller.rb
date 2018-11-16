class Api::UsersController < Api::BaseController
  before_action :user_exists?, only: :show

  #
  # ユーザの詳細を取得
  #
  def show
    render json: JSON::User.raw(user)
  end

  private

    #
    # 詳細取得対象のユーザ
    #
    def user
      @user ||= User.find_by(id: params[:id])
    end

    #
    # 詳細取得対象ユーザが存在するか?
    #
    def user_exists?
      raise404 'user_not_found' if user.blank?
    end
end
