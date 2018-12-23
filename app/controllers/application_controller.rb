class ApplicationController < ActionController::Base
  include Knock::Authenticable

  # TODO: 一時的な対応なので必ずお治す
  protect_from_forgery with: :null_session
end
