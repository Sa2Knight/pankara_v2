require_relative '../../support/common_contexts'

describe 'events#update', type: :request do
  include_context 'request spec common'

  let(:current_user) { FactoryBot.create(:user) }
  let(:event_user) { current_user }
  let(:event) { FactoryBot.create(:event, user: event_user) }
  let(:event_id) { event.id }
  let(:params) do
    {
      title: title,
      date: date
    }
  end
  let(:title) { nil }
  let(:date) { nil }

  before do
    request(:put, "/api/events/#{event_id}", params: params, user: current_user)
  end

  shared_examples '更新に成功する' do
    it 'ステータスが200' do
      expect(status).to eq 200
    end
    it 'カラオケが更新されている' do
      event.reload
      expect(event.title).to eq title
      expect(event.date.to_s).to eq date
    end
  end

  describe '正常系' do
    context 'タイトルと日付を変更する場合' do
      let(:title) { SecureRandom.hex(8) }
      let(:date) { (Time.zone.today - 1).to_s }
      it_behaves_like '更新に成功する'
    end
    context '何も変更しない場合' do
      let(:title) { nil }
      let(:date) { nil }
      it 'ステータスは200だが更新されない' do
        expect(status).to eq 200
        expect(event.title).to eq event.reload.title
      end
    end
  end

  describe '異常系' do
    context 'ログインしていない場合' do
      let(:current_user) { nil }
      let(:event_user) { FactoryBot.create(:user) }
      it_behaves_like '401'
    end
    context 'カラオケオーナーでないユーザの場合' do
      let(:event_user) { FactoryBot.create(:user) }
      it_behaves_like '403'
    end
    context 'カラオケが存在しない場合' do
      let(:event_id) { 0 }
      it_behaves_like '404'
    end
    context 'タイトルの文字数がオーバーしている場合' do
      let(:title) { SecureRandom.hex(25) }
      it_behaves_like '400'
    end
    context '日付のフォーマットがおかしい場合' do
      let(:date) { '今日' }
      it_behaves_like '400'
    end
    context '日付が未来を示している場合' do
      let(:date) { (Time.zone.today + 1).to_s }
      it_behaves_like '400'
    end
  end
end
