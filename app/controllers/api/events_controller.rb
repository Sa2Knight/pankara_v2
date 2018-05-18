class Api::EventsController < ApplicationController
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
      Event.all.includes(%i[product store users])
    end
end
