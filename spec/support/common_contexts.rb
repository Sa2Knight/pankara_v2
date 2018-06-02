shared_context 'request spec common' do
  let(:score_type) { FactoryBot.create(:score_type) }
  let(:product)    { FactoryBot.create(:product) }

  let(:headers) { response.headers }
  let(:body)    { JSON.parse(response.body) }
  let(:first)   { body.first }
  let(:size)    { body.size }

  def request(method, url, params: nil, user:)
    login(user) if user && @jwt.blank?
    send(method, url, params: params, headers: { Authorization: @jwt })
  end

  def login(user)
    auth_params = {
      auth: {
        name: user.name,
        password: '1q2w3e4r'
      }
    }
    post '/user_token', params: auth_params
    @jwt = JSON.parse(response.body)['jwt']
  end
end
