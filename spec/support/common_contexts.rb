shared_context 'request spec common' do
  let(:score_type) { FactoryBot.create(:score_type) }
  let(:product)    { FactoryBot.create(:product) }

  let(:headers) { response.headers }
  let(:body)    { JSON.parse(response.body) }
  let(:first)   { body.first }
  let(:size)    { body.size }
end
