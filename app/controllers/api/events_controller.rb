class Api::EventsController < Api::BaseController
  #
  # イベントの一覧を取得
  #
  def index
    render json: events.map { |event| JSON::Event.generate(event) }
  end

  private

    #
    # 一覧取得対象のイベント一覧
    #
    def events
      Event
        .page(params[:page])
        .per(params[:per])
        .includes(%i[product store user_events users])
    end
end
