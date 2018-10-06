require_relative '../../support/common_contexts'

RSpec.describe 'events#show', type: :request do
  include_context 'request spec common'

  let(:current_user) { FactoryBot.create(:user) }
  let(:event)    { FactoryBot.create(:event) }
  let(:event_id) { event.id }

  before do
    before_request if defined? before_request
    request(:get, "/api/events/#{event_id}")
  end

  describe 'シリアライズ関係' do
    let(:event) do
      users = FactoryBot.create_list(:user, 2)
      event = FactoryBot.create(:event, title: 'イベントタイトル')
      event.user_events.create(
        [
          { user: users[0] },
          { user: users[1] }
        ]
      )
      FactoryBot.create_list(:history, 3, user_event: event.user_events.first)
      FactoryBot.create_list(:history, 3, user_event: event.user_events.last)
      event
    end

    it 'シリアライズされたイベント詳細が取得できる' do
      expect(status).to eq 200
      expect(body['title']).to eq 'イベントタイトル'
      expect(body['history_size']).to eq 6
      expect(body['members'].size).to eq 2
      expect(body['members'].first['history_size']).to eq 3
    end
  end

  describe '異常系' do
    context 'イベントが存在しない場合' do
      let(:event_id) { 0 }
      it_behaves_like '404'
    end
  end
end
