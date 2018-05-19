class Api::BaseController < ApplicationController
  before_action :params_reset

  before_action :sort_params_valid?, only: :index
  after_action :set_respons_header, only: :index

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
    raise StandardError unless @index
    response.headers['total-count'] = @index.total_count
    response.headers['total-pages'] = @index.total_pages
  end

  #
  # 一覧取得APIにおける、ソートパラメータの有効性を検証する
  #
  def sort_params_valid?
    return raise400 unless params[:sort_key].in? sortable_keys
    raise400 unless params[:sort_order].in? %w[asc desc]
  end

  # TODO: エラーレスポンスを汎用化させる
  def raise400
    render json: { message: 'params_invalid' }, status: :bad_request
  end

  #
  # 各子クラスが対象とするモデルを定義する
  #
  def model
    raise NotImplementedError
  end
end
