class Api::ArtistsController < Api::BaseController
  before_action :artist_exists?, only: %i[show histories]

  #
  # 歌手の詳細を取得
  #
  def show
    render json: JSON::Artist.show(artist)
  end

  private

  #--- 共通privateメソッド

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
