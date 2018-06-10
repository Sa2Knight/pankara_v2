class Api::UserTokenController < Knock::AuthTokenController
  skip_before_action :verify_authenticity_token

  def entity
    User.find_by(name: params[:auth][:name])
  end

  def auth_params
    params.require(:auth).permit :name, :password
  end
end
