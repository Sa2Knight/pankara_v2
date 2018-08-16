require_relative '../../support/common_contexts'
RSpec.describe 'songs#show', type: :request do
  include_context 'request spec common'

  let(:current_user) { FactoryBot.create(:user) }
  let(:song)    { FactoryBot.create(:song) }
  let(:song_id) { song.id }

  before do
    before_request if defined? before_request
    request(:get, "/api/songs/#{song_id}", user: current_user)
  end

  describe 'シリアライズ関係' do
    it '対象の楽曲情報が取得できる' do
      expect(response.status).to eq 200
      expect(Song.find(body['id'])).to eq song
      expect(body['name']).to eq song.name
      expect(body['url']).to eq song.url
    end
  end

  describe '歌手情報関係' do
    it 'レスポンスに歌手情報が含まれている' do
      expect(body.key?('artist')).to be true
      expect(Artist.find(body['artist']['id'])).to eq song.artist
      expect(body['artist']['name']).to eq song.artist.name
    end
  end

  describe '歌唱回数関係' do
    context 'ログインしている場合' do
      context '歌唱履歴が存在する場合' do
        let(:before_request) do
          current_user = FactoryBot.create(:user)
          other_user   = FactoryBot.create(:user)
          event        = FactoryBot.create(:event)
          user_events = event.user_events.create(
            [
              { user: current_user },
              { user: other_user   }
            ]
          )
          FactoryBot.create_list(:history, 2,
                                 song: song, user_event: user_events[0])
          FactoryBot.create_list(:history, 3,
                                 song: song, user_event: user_events[1])
        end

        it '自身と全体の歌唱回数がレスポンスに含まれている' do
          expect(body['my_histories_count']).to eq 2
          expect(body['histories_count']).to eq 2 + 3
        end
      end

      context '歌唱履歴が存在しない場合' do
        let(:before_request) { FactoryBot.create(:user) }
        it '歌唱履歴数が0になる' do
          expect(body['my_histories_count']).to eq 0
          expect(body['histories_count']).to eq 0
        end
      end
    end
    xcontext 'ログインしていない場合' do
      # TODO: ログイン系実装後に追加
      it 'my_histories_countが0になる' do
        expect(body['my_histories_count']).to eq 0
      end
    end
  end

  describe '集計情報関係' do
    # 詳細はサービスクラスのテストが別途ある
    it 'レスポンスに集計情報が含まれている' do
      expect(body.key?('graph'))
      expect(body['graph'].keys).to match_array(
        %w[histories_by_month satisfactions
           scores_by_score_type histories_by_user]
      )
    end
  end

  describe 'エラー系' do
    context '存在しないIDを指定した場合' do
      let(:song_id) { 0 }
      it_behaves_like '404'
    end
  end
end
