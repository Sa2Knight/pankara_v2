# 共通エラー処理
module ErrorHandlers
  extend ActiveSupport::Concern
  # NOTE: エラーの種類 大体は網羅
  # データ形式が間違っている場合
  class BadRequestError < StandardError; end
  # 何らかの認証が必要な場合
  class UnauthorizedError < StandardError; end
  # アクセス禁止、権限がない場合等
  class ForbiddenError < StandardError; end
  # 存在しない場合。または、存在することを隠したい場合
  class NotFoundError < StandardError; end
  # パッチ、削除しようとしたリソースがロック中（楽観・悲観どちらでも）の場合
  class ConflictError < StandardError; end
  # データ形式は間違っていなくて処理もできるがビジネスロジック上受け入れてはいけない場合
  class UnprocessableError < StandardError; end
  # その他のサーバに起因するエラーにより処理続行できない場合
  class ServerError < StandardError; end

  included do
    rescue_from ServerError, with: :rescue500
    rescue_from BadRequestError, with: :rescue400
    rescue_from ArgumentError, with: :rescue400
    rescue_from UnauthorizedError, with: :rescue401
    rescue_from ForbiddenError, with: :rescue403
    rescue_from NotFoundError, with: :rescue404
    # Routingerrorアプリ側で特に対応してないので拾って大丈夫
    rescue_from ActionController::RoutingError, with: :rescue404
    rescue_from ConflictError, with: :rescue409
    rescue_from UnprocessableError, with: :rescue422
  end

  private_class_method

  def self.generate_method(status)
    define_method("rescue#{status}".to_sym) do |exception|
      output_log(exception)
      render(
        json: { message: exception.message,
                display_message: I18n.t("v2.errors.#{exception.message}") },
        status: status.to_i
      )
    end
  end

  private

    [400, 403, 404, 422, 500].each do |status|
      generate_method(status)
    end

    def raise400(message = 'params_invalid')
      raise BadRequestError, message
    end

    def raise403(message = 'forbidden')
      raise ForbiddenError, message
    end

    def raise404(message = 'not_found')
      raise NotFoundError, message
    end

    def raise422(message = 'failed')
      raise UnprocessableError, message
    end

    def output_log(exception)
      logger.error exception.message
    end
end
