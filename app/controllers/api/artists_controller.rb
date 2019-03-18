class Api::ArtistsController < Api::BaseController
  before_action :artist_exists?, only: %i[show histories]

  #
  # 歌手名の一覧を取得
  # NOTE: ページングを無効にして全件取得する
  #
  def names
    params[:page] = 1
    params[:per] = 9999
    render json: artists.pluck(:name)
  end

  #
  # 歌手の詳細を取得
  #
  def show
    render json: JSON::Artist.show(artist, user: current_user)
  end

  private

  #--- 共通privateメソッド

  #
  # 取得対象の歌手一覧を取得
  #
  def artists
    @index = Artist
             .name_by(params[:name])
             .song_name_by(params[:song_name])
             .order(params[:sort_key] => params[:sort_order])
             .page(params[:page])
             .per(params[:per])
  end

  #
  # 取得対象の歌手を取得
  #
  def artist
    @artist ||= Artist.find_by(id: params[:id])
  end

  #
  # 対象の歌手が存在するか？
  #
  def artist_exists?
    raise404 'artist_not_found' if artist.blank?
  end
end
