class Api::BaseController < ApplicationController
  include ErrorHandlers

  # REVIEW: ページングを使う一覧系APIごとに呼び出すで良いかも
  #         と考えるとここじゃなくてconcernで良いかも
  before_action :params_reset
  after_action :set_respons_header, only: %i[index histories]

  #
  # リクエストパラメータの初期化を行う
  #
  def params_reset
    params[:page] ||= CONSTANT::DEFAULT::PAGE
    params[:per]  ||= CONSTANT::DEFAULT::PER_PAGE
    if params[:per].to_i > CONSTANT::CAP::PER_PAGE
      params[:per] = CONSTANT::CAP::PER_PAGE
    end
    params[:sort_key] ||= CONSTANT::DEFAULT::SORT_KEY
    params[:sort_order] ||= CONSTANT::DEFAULT::SORT_ORDER
  end

  #
  # 必要に応じてレスポンスヘッダーを設定する
  #
  def set_respons_header
    response.headers['total-count'] = @index&.total_count
    response.headers['total-pages'] = @index&.total_pages
  end

end
