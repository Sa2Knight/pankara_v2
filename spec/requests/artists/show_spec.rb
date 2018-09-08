require_relative '../../support/common_contexts'
RSpec.describe 'artists#show', type: :request do
  include_context 'request spec common'

  let(:current_user) { FactoryBot.create(:user) }
  let(:artist)       { FactoryBot.create(:artist) }
  let(:artist_id)    { artist.id }

  before do
    request(:get, "/api/artists/#{artist_id}", user: current_user)
  end

  describe '正常系' do
    describe '基本情報の検証' do
      it do
        expect(body['id']).to eq artist.id
        expect(body['name']).to eq artist.name
        expect(body['description']).to eq artist.description
        expect(body['url']).to eq artist.url
      end
    end
  end

  describe '異常系' do
    context '歌手が存在しない場合' do
      let(:artist_id) { 0 }
      it_behaves_like '404'
    end
  end
end
