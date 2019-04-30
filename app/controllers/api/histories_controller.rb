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
    history = update_new_history
    render json: JSON::History.show(history)
  rescue ActiveRecord::RecordInvalid => e
    raise400 e.record.full_error_message
  end

  #
  # [endopint] 更新
  # NOTE: 実態はcreated_atのみ保持してレコード再作成
  #
  def update
    history = update_new_history(created_at: new_history.created_at)
    render json: JSON::History.show(history)
  rescue ActiveRecord::RecordInvalid => e
    raise400 e.record.full_error_message
  end

  private

  def update_new_history(created_at: DateTime.now)
    new_history.update!(
      event_date: event.date,
      key: params[:key],
      song: Song.find_or_create_by!(
        song_name: params[:song_name],
        artist_name: params[:artist_name]
      ),
      user_event: UserEvent.find_by(
        user_id: params[:user_id], event: event
      ),
      satisfaction: params[:satisfaction],
      comment: params[:comment],
      created_at: created_at
    )
    @new_history
  end

  #
  # NOTE: 単純なメソッドチェインのためrubocopを無視
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

  def new_history
    @new_history ||= params[:id].present? ? history : History.new
  end

  def event
    current_user.events.find_by(id: params[:event_id]) || raise404('event_not_found')
  end
end
