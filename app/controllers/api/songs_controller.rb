class Api::SongsController < Api::BaseController
  before_action :song_exists?, only: %i[show histories users]

  #
  # 楽曲の一覧を取得
  #
  def index
    if params[:with_artist]
      songs_json = songs.includes(:artist).map do |song|
        JSON::Song.raw_with_artist(song)
      end
      render json: songs_json
    else
      render json: songs.map { |song| JSON::Song.raw(song) }
    end
  end

  #
  # 曲名の一覧を取得
  # NOTE: ページングを無効にして全件取得する
  #
  def names
    params[:page] = 1
    params[:per] = 9999
    render json: songs.pluck(:name)
  end

  #
  # 楽曲の詳細を取得
  #
  def show
    render json: JSON::Song.show(song, current_user)
  end

  #
  # 楽曲を持ち歌にしているユーザー一覧を取得
  #
  def users
    history_count_each_users = song.history_count_each_users
    users_json = song.users.map do |user|
      JSON::User.raw(user).merge(
        count: history_count_each_users[user.id]
      )
    end
    render json: users_json
  end

  #
  # 一覧取得対象の楽曲一覧
  # rubocop: disable Metrics/AbcSize
  #
  def songs
    @index = Song
             .user_by(params[:user_id])
             .artist_by(params[:artist_id])
             .artist_name_by(params[:artist_name])
             .name_by(params[:name])
             .order(params[:sort_key] => params[:sort_order])
             .page(params[:page])
             .per(params[:per])
  end
  # rubocop: enable Metrics/AbcSize

  #
  # 詳細取得対象の楽曲
  #
  def song
    @song ||= Song.find_by(id: params[:id])
  end

  #
  # 詳細取得対象の楽曲が存在するか?
  #
  def song_exists?
    raise404 'song_not_found' if song.blank?
  end

  #
  # 歌唱履歴一覧取得対象のユーザが存在するか?
  #
  def user_exists?
    return true if params[:user_id].blank?
    return true if User.exists?(params[:user_id])
    raise404 'user_not_found'
  end
end
