# 共通エラー処理
module ErrorHandlers
  extend ActiveSupport::Concern
  class BadRequestError < StandardError; end
  class ForbiddenError < StandardError; end
  class NotFoundError < StandardError; end
  class ServerError < StandardError; end

  included do
    rescue_from ServerError, with: :rescue500
    rescue_from BadRequestError, with: :rescue400
    rescue_from ForbiddenError, with: :rescue403
    rescue_from NotFoundError, with: :rescue404
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

    [400, 403, 404, 500].each do |status|
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

    def output_log(exception)
      logger.error exception.message
    end
end
