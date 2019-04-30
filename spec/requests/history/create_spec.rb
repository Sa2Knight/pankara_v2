require_relative '../../support/common_contexts'
RSpec.describe 'history#create', type: :request do
  include_context 'request spec common'

  let(:current_user) { FactoryBot.create(:user) }

  let(:params) do
    {
      event_id: event_id,
      user_id: user_id,
      song_name: song_name,
      artist_name: artist_name,
      key: key
    }
  end
  let(:event) { FactoryBot.create(:event) }
  let(:event_id) { event.id }
  let(:user_id) { FactoryBot.create(:user_event, user: current_user, event: event).user_id }
  let(:song_name) { '天体観測' }
  let(:artist_name) { 'BUMP OF CHICKEN' }
  let(:key) { -3 }

  before do
    request(:post, '/api/histories/', user: current_user, params: params)
  end

  describe '正常系' do
    it '歌唱履歴が作成される' do
      expect(History.exists?(id: body['id'])).to eq true
    end
  end

  describe '異常系' do
    context 'カラオケに参加していない場合' do
      let(:user_id) { FactoryBot.create(:user).id }
      it_behaves_like '404'
    end

    context 'バリデーションエラーを起こした場合' do
      let(:song_name) { 'a' * 81 }
      it_behaves_like '400'
    end
  end
end
