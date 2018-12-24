class Api::EventsController < Api::BaseController
  # 事前認証
  before_action :logged_in_or_401, only: %i[create update]
  before_action :updatable_or_403, only: :update

  # パラメータチェック
  before_action :datetime_present_or_400, only: :create
  before_action :datetime_past_or_400, only: %i[create update]
  before_action :users_valid_or_400, only: :create

  #
  # [endpoint] 一覧
  #
  def index
    render json: events.map { |event| JSON::Event.index(event) }
  end

  #
  # [endpoint] 詳細
  #
  def show
    render json: JSON::Event.show(event)
  end

  #
  # [endpoint] 作成
  #
  def create
    event = Event.create!(event_params.merge(user_id: current_user.id))
    Array(params[:users]).each do |user_id|
      event.user_events.create!(user_id: user_id)
    end
    render json: JSON::Event.show(event)
  rescue ActiveRecord::RecordInvalid => e
    raise400 e.record.full_error_message
  end

  #
  # [endpoint] 更新
  #
  def update
    event.update!(event_params.to_h.compact)
    render json: JSON::Event.show(event)
  rescue ActiveRecord::RecordInvalid => e
    raise400 e.record.full_error_message
  end

  private

  # rubocop: disable Metrics/AbcSize
  def events
    @index = Event
             .title_like(params[:title])
             .by_member(params[:members])
             .order(params[:sort_key] => params[:sort_order])
             .page(params[:page])
             .per(params[:per])
             .includes([user_events: [:user]])
  end
  # rubocop: enable Metrics/AbcSize

  def event
    return @event if @event.present?
    (@event = Event.find_by(id: params[:id])) || raise404('event_not_found')
  end

  def event_params
    params.permit(:title, :datetime)
  end

  # [check] 編集/削除可能か？
  def updatable_or_403
    event.editable_by?(user: current_user) || raise403
  end

  #
  # TODO: この辺カスタムバリデーション入れたほうが絶対良い
  # コントローラでやることじゃないと思う。
  #

  # [check] datetimeが指定されているか？
  def datetime_present_or_400
    raise400 if params[:datetime].blank?
  end

  # [check] datetimeが有効な過去の日付か？
  def datetime_past_or_400
    return if params[:datetime].blank?

    raise400 unless Date.valid_by?(params[:datetime])
    raise400 if Date.parse(params[:datetime]).future?
  end

  # [check] usersが全てフレンドか？
  def users_valid_or_400
    return if params[:user_ids].blank?
    raise400 unless current_user.friend_all?(params[:user_ids])
  end
end
