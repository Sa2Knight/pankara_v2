require_relative '../../support/common_contexts'
RSpec.describe 'products#index', type: :request do
  include_context 'request spec common'

  let!(:products) { FactoryBot.create_list(:product, 3) }

  before do
    before_request if defined? before_request
    request(:get, '/api/products')
  end

  describe '正常系' do
    it '一覧が取得できる' do
      expect(size).to eq 3
      expect(first['brand']).to eq products.first.brand
      expect(first['name']).to eq products.first.name
      expect(first['full_name']).to eq products.first.full_name
    end
  end

end
