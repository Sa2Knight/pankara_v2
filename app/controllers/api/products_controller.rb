class Api::ProductsController < Api::BaseController
  #
  # 機種一覧を取得
  #
  def index
    render json: Product.all.map { |product| JSON::Product.raw(product) }
  end

end
