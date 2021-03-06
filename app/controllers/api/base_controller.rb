class Api::BaseController < ApplicationController
  include Authentications
  include ErrorHandlers

  # REVIEW: ページングを使う一覧系APIごとに呼び出すで良いかも
  #         と考えるとここじゃなくてconcernで良いかも
  before_action :params_reset
  after_action :set_respons_header, only: %i[index histories my_songs]

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

  #
  # ログインしていない場合、401エラーを戻す
  #
  def authorized?
    raise401 if current_user.blank?
  end

end
