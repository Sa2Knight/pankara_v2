class Api::HistoriesController < Api::BaseController
  #
  # [endpoint] 一覧
  #
  def index
    render json: histories.map { |history| JSON::History.make(history) }
  end

  #
  # [endpoint] 取得
  #
  def show
    render json: JSON::History.show(history)
  end

  private

  #
  # 取得対象の歌唱履歴一覧
  # rubocop: disable Metrics/AbcSize
  #
  def histories
    @index = History
             .by_user_id(params[:user_id])
             .by_event(params[:event_id])
             .by_song(params[:song_id])
             .by_artist(params[:artist_id])
             .order(params[:sort_key] => params[:sort_order])
             .page(params[:page])
             .per(params[:per])
             .includes([:user, :event, song: :artist])
  end
  # rubocop: enable Metrics/AbcSize

  #
  # 取得対象の歌唱履歴
  #
  def history
    History.find_by(id: params[:id]) || raise404('history_not_found')
  end
end
