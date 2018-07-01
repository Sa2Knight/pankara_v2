class Api::HistoriesController < Api::BaseController

  #
  # 歌唱履歴の詳細を取得
  #
  def show
    render json: JSON::History.show(history)
  end

  private

    #
    # 取得対象の歌唱履歴
    #
    def history
      History.find_by(id: params[:id]) || raise404('history_not_found')
    end
end
