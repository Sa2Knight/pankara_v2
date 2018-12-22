class Api::EventsController < Api::BaseController
  before_action :logged_in_or_401, only: :create
  before_action :event_params_valid_or_400, only: :create

  #
  # イベントの一覧を取得
  #
  def index
    render json: events.map { |event| JSON::Event.index(event) }
  end

  #
  # イベントの詳細を取得
  #
  def show
    render json: JSON::Event.show(event)
  end

  #
  # イベントを新規作成
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

  private

  #
  # 一覧取得対象のイベント一覧
  # rubocop: disable Metrics/AbcSize
  #
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

  #
  # 取得対象のイベント
  #
  def event
    return @event if @event.present?
    (@event = Event.find_by(id: params[:id])) || raise404('event_not_found')
  end

  #
  # 作成更新で許可するパラメータ
  #
  def event_params
    params.permit(:title, :datetime)
  end

  #
  # 作成更新で許可するパラメータが不正なら400
  # 日付は入力必須
  # 日付は過去でなければならない
  # 参加者は全て友達でなければならない
  #
  def event_params_valid_or_400
    raise400 unless Date.valid_by?(params[:datetime])
    raise400 if Date.parse(params[:datetime]).future?
    raise400 unless current_user.friend_all?(params[:user_ids])
  end
end
