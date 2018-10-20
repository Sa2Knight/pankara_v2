require_relative '../../support/common_contexts'
RSpec.describe 'artists#show', type: :request do
  include_context 'request spec common'

  let(:current_user) { FactoryBot.create(:user) }
  let(:other_user)   { FactoryBot.create(:user) }
  let(:artist)       { FactoryBot.create(:artist) }
  let(:artist_id)    { artist.id }

  subject do
    request(:get, "/api/artists/#{artist_id}", user: current_user)
    JSON.parse(response.body).deep_symbolize_keys
  end

  describe '正常系' do
    describe 'レスポンス構成の検証' do
      it do
        should include(
          :id,
          :name,
          :description,
          :url,
          :songs,
        )
      end
    end
    describe '基本情報の検証' do
      it do
        expect(subject[:id]).to eq artist.id
        expect(subject[:name]).to eq artist.name
        expect(subject[:description]).to eq artist.description
        expect(subject[:url]).to eq artist.url
      end
    end
    describe '楽曲一覧の検証' do
      context '楽曲が登録されていない場合' do
        it { expect(subject[:songs]).to be_empty }
      end
      context '楽曲が登録されている場合' do
        before { FactoryBot.create_list(:song, 3, artist: artist) }
        it { expect(subject[:songs].size).to eq 3 }
      end
      context '歌唱履歴が登録されている場合' do
        before do
          song = FactoryBot.create(:song, artist: artist)
          FactoryBot.create_list(:history, 3, song: song, user: current_user)
          FactoryBot.create(:history, song: song, user: other_user)
        end
        it do
          expect(subject[:songs].first[:histories_count]).to eq 3 + 1
          expect(subject[:songs].first[:histories_count_by_me]).to eq 3
        end
      end
    end
  end

  describe '異常系' do
    before { subject }

    context '歌手が存在しない場合' do
      let(:artist_id) { 0 }
      it_behaves_like '404'
    end
  end
end
