require_relative '../../support/common_contexts'
RSpec.describe 'artists#histories', type: :request do
  include_context 'request spec common'

  let(:current_user) { FactoryBot.create(:user) }
  let(:artist)       { FactoryBot.create(:artist) }
  let(:song)         { FactoryBot.create(:song, artist: artist) }
  let(:artist_id)    { artist.id }

  let(:page) { nil }
  let(:per)  { nil }
  let(:params) { { page: page, per: per } }
  let(:request_api) do
    request(:get, "/api/artists/#{artist_id}/histories",
            user: current_user, params: params)
  end

  describe '正常系' do
    describe 'レスポンス内容' do
      subject do
        request_api
        body.first.deep_symbolize_keys
      end
      let!(:history) { FactoryBot.create(:history, song: song) }

      it 'レスポンスの構成が正しい' do
        expect include(
          id: history.id,
          key: history.key,
          satisfaction: history.satisfaction,
          comment: history.comment,
          score: history.score,
          user: {
            id: history.user.id,
            display_name: history.user.display_name,
            image_url: history.user.image_url
          },
          event: {
            id: history.event.id,
            datetime: history.event.datetime.strftime(CONSTANT::FORMAT::DATE),
            title: history.event.title
          },
          song: {
            id: history.song.id,
            artist_id: history.song.artist.id,
            name: history.song.name,
            url: history.song.url
          }
        )
      end
    end

    describe 'ページング' do
      subject do
        request_api
        body
      end
      let!(:histories) do
        stub_const('CONSTANT::DEFAULT::PER_PAGE', 5)
        FactoryBot.create_list(:history, CONSTANT::DEFAULT::PER_PAGE + 1, song: song)
      end

      context '指定しない場合' do
        it 'デフォルトの件数が返ってくる' do
          expect(subject.size).to eq CONSTANT::DEFAULT::PER_PAGE
          expect(headers['total-count']).to eq CONSTANT::DEFAULT::PER_PAGE + 1
        end
      end

      context 'per=2, page=2 を指定した場合' do
        let(:per) { 2 }
        let(:page) { 2 }
        it '3,4件目のみ返ってくる' do
          expect(subject.size).to eq 2
          expect(subject[0]['id']).to eq histories[2].id
          expect(subject[1]['id']).to eq histories[3].id
        end
      end
    end
  end

  describe '異常系' do
    subject { request_api }
    before { subject }

    context '歌手が存在しない場合' do
      let(:artist_id) { 0 }
      it_behaves_like '404'
    end
  end
end
