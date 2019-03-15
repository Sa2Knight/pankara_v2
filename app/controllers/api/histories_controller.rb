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

  #
  # [endpoint] 作成
  #
  def create
    binding.pry
    history = History.create(
      event_date: event.date,
      key: history_params[:key],
      song: Song.find_or_create_by!(
        song_name: history_params[:song_name],
        artist_name: history_params[:artist_name]
      ),
      user_event: UserEvent.find_by(
        user_id: history_params[:user_id],
        event: event
      )
    )
    render json: JSON::History.show(history)
  rescue ActiveRecord::RecordInvalid => e
    raise400 e.record.full_error_message
  end

  private

  #
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

  def history
    History.find_by(id: params[:id]) || raise404('history_not_found')
  end

  def event
    current_user.events.find_by(id: history_params[:event_id]) || raise404('event_not_found')
  end

  def history_params
    params.permit(:event_id, :user_id, :song_name, :artist_name, :key)
  end
end
