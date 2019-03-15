require_relative '../../support/common_contexts'

RSpec.describe 'songs#name', type: :request do
  include_context 'request spec common'

  let(:params) { {} }
  let!(:songs) { [] }
  before do
    request(:get, '/api/songs/names', params: params)
  end

  context '楽曲が存在する場合' do
    let(:songs) do
      [
        FactoryBot.create(:song, name: '天体観測'),
        FactoryBot.create(:song, name: 'ロストマン')
      ]
    end
    it '曲名の一覧が取得できる' do
      expect(body).to match_array %w[天体観測 ロストマン]
    end
  end
end
