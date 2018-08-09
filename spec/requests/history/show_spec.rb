require_relative '../../support/common_contexts'
RSpec.describe 'history#show', type: :request do
  include_context 'request spec common'

  let(:current_user) { FactoryBot.create(:user) }
  let(:history)      { FactoryBot.create(:history) }
  let(:history_id)   { history.id }

  before do
    request(:get, "/api/histories/#{history_id}", user: current_user)
  end

  describe '正常系' do
    it '対象の歌唱履歴が取得できる' do
      expect(History.exists?(body['id'])).to be true
      expect(User.exists?(body['user']['id'])).to be true
      expect(Event.exists?(body['event']['id'])).to be true
      expect(Song.exists?(body['song']['id'])).to be true
    end
  end

  describe 'エラー系' do
    context '存在しないIDを指定した場合' do
      let(:history_id) { 0 }
      it_behaves_like '404'
    end
  end
end
