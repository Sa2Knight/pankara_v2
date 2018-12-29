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

  #
  # ユーザの持ち歌一覧を取得
  #
  def my_songs
    render json: users_my_songs.map { |song| JSON::Song.raw_with_artist(song) }
  end

  private

  #
  # 対象ユーザ
  #
  def user
    @user ||= User.find_by(id: params[:id])
  end

  #
  # 対象ユーザの持ち歌一覧
  #
  def users_my_songs
    @index = Song.where(id: user.my_song_ids)
                 .page(params[:page])
                 .per(params[:per])
                 .includes(:artist)
  end

  #
  # 詳細取得対象ユーザが存在するか?
  #
  def user_present_or_404
    raise404 'user_not_found' if user.blank?
  end
end
