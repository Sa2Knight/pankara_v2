require_relative '../../support/common_contexts'

xdescribe 'events#index', type: :request do
  include_context 'request spec common'

  let(:current_user) { FactoryBot.create(:user) }
  let(:params) do
    {
      title: title,
      date: date,
      users: users
    }
  end
  let(:title) { nil }
  let(:date)  { nil }
  let(:users) { nil }

  let(:created_event) { Event.find_by(date: date) }

  before do
    before_request if defined? before_request
    request(:post, '/api/events', params: params, user: current_user)
  end

  shared_examples '登録に成功する' do
    it 'ステータスが200' do
      expect(status).to eq 200
    end
    it 'カラオケが生成されている' do
      expect(created_event.present?).to be true
    end
  end

  describe '正常系' do
    context 'タイトルを省略した場合' do
    end
    context '日付が過去の場合' do
    end
    context 'メンバーを指定した場合' do
    end
  end

  describe '異常系' do
    context 'ログインしていない場合' do
      let(:current_user) { nil }
    end
    context 'タイトルの文字数がオーバーしている場合' do
    end
    context '日付を指定してない場合' do
    end
    context '日付のフォーマットがおかしい場合' do
    end
    context '日付が未来を示している場合' do
    end
    context 'メンバーに存在しないユーザを含んでいる場合' do
    end
  end
end
