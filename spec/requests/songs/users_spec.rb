require_relative '../../support/common_contexts'
RSpec.describe 'songs#users', type: :request do
  include_context 'request spec common'

  let(:song) { FactoryBot.create(:song) }
  let(:song_id) { song.id }

  before do
    before_request if defined? before_request
    request(:get, "/api/songs/#{song_id}/users")
  end

  describe '正常系' do
    context '歌唱履歴がある場合' do
      let(:before_request) do
        user1 = FactoryBot.create(:user, display_name: 'ないと')
        user2 = FactoryBot.create(:user, display_name: 'とも')
        FactoryBot.create(
          :history, song: song, user_event: FactoryBot.create(:user_event, user: user1)
        )
        FactoryBot.create(
          :history, song: song, user_event: FactoryBot.create(:user_event, user: user1)
        )
        FactoryBot.create(
          :history, song: song, user_event: FactoryBot.create(:user_event, user: user2)
        )
      end

      it '歌唱履歴のあるユーザ一覧が返却される' do
        expect(status).to eq 200
        expect(body.size).to eq 2
        expect(body[0]['display_name']).to eq 'ないと'
        expect(body[0]['count']).to eq 2
        expect(body[1]['count']).to eq 1
      end
    end

    context '歌唱履歴がない場合' do
      it { expect(body).to be_empty }
    end
  end

  describe '異常系' do
    context '楽曲が存在しない場合' do
      let(:song_id) { 0 }
      it_behaves_like '404'
    end
  end
end
