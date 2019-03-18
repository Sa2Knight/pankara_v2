require_relative '../../support/common_contexts'

RSpec.describe 'artists#name', type: :request do
  include_context 'request spec common'

  let(:params) { { name: name, song_name: song_name } }
  let(:name) { nil }
  let(:song_name) { nil }
  let!(:artists) { [] }

  before do
    before_request if defined? before_request
    request(:get, '/api/artists/names', params: params)
  end

  context '歌手が存在する場合' do
    let(:artists) do
      [
        FactoryBot.create(:artist, name: 'BUMP OF CHICKEN'),
        FactoryBot.create(:artist, name: '米津玄師')
      ]
    end

    it '曲名の一覧が取得できる' do
      expect(body).to match_array ['BUMP OF CHICKEN', '米津玄師']
    end

    context '歌手名で絞り込んだ場合' do
      let(:name) { 'OF' }

      it '対象の歌手のみ取得できる' do
        expect(body).to match_array ['BUMP OF CHICKEN']
      end
    end

    context '曲名で絞り込んだ場合' do
      let(:song_name) { 'Lemon' }
      let(:before_request) do
        FactoryBot.create(:song, name: 'Lemon', artist: artists.last)
      end

      it '対象の歌手のみ取得できる' do
        expect(body).to match_array ['米津玄師']
      end
    end
  end
end
