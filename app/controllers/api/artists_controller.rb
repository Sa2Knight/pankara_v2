class Api::ArtistsController < Api::BaseController
  before_action :artist_exists?, only: %i[show histories]

  #
  # 歌手の詳細を取得
  #
  def show
    render json: JSON::Artist.show(artist)
  end

  #
  # 歌手の歌唱履歴を取得
  #
  def histories
    histories_json = artist_histories.map do |history|
      JSON::History.artist_index(history)
    end
    render json: histories_json
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

  #--- histories用privateメソッド

  #
  # 対象歌手の歌唱履歴
  #
  def artist_histories
    @index ||= artist.histories
                     .page(params[:page])
                     .per(params[:per])
                     .includes(:user, :event, :song)
  end
end
