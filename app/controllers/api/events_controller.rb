class Api::EventsController < Api::BaseController
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

  private

    #
    # 一覧取得対象のイベント一覧
    # TODO: ABCSize
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

    #
    # 取得対象のイベント
    #
    def event
      return @event if @event.present?
      (@event = Event.find_by(id: params[:id])) || raise404('event_not_found')
    end
end
