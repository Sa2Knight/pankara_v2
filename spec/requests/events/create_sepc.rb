require_relative '../../support/common_contexts'

describe 'events#create', type: :request do
  include_context 'request spec common'

  let(:current_user) { FactoryBot.create(:user) }
  let(:params) do
    {
      title: title,
      datetime: datetime,
      users: users
    }
  end
  let(:title) { nil }
  let(:datetime) { Time.zone.today.to_s }
  let(:users) { nil }

  let(:created_event) { Event.find_by(datetime: datetime) }

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
      expect(UserEvent.exists?(event: created_event, user: current_user)).to be true
    end
  end

  describe '正常系' do
    context 'タイトルを省略しなかった場合' do
      let(:title) { SecureRandom.hex(6) }
      it_behaves_like '登録に成功する'
      it '設定したカラオケタイトルが反映される' do
        expect(created_event.title).to eq title
      end
    end
    context 'タイトルを省略した場合' do
      let(:title) { nil }
      it_behaves_like '登録に成功する'
      it 'カラオケタイトルはnilになっている' do
        expect(created_event.title).to be_nil
      end
    end
    context '日付が過去の場合' do
      let(:datetime) { (Time.zone.today - 1).to_s }
      it_behaves_like '登録に成功する'
    end
    context 'メンバーを指定した場合' do
      # TODO: フレンド機能実装したらそれの考慮追加する
      let!(:friend) { FactoryBot.create(:user) }
      let(:users) { [friend.id] }
      it_behaves_like '登録に成功する'
      it 'メンバーがカラオケに参加している' do
        expect(UserEvent.exists?(event: created_event, user: friend)).to be true
      end
    end
  end

  describe '異常系' do
    context 'ログインしていない場合' do
      let(:current_user) { nil }
      it_behaves_like '401'
    end
    context 'タイトルの文字数がオーバーしている場合' do
      let(:title) { SecureRandom.hex(25) }
      it_behaves_like '400'
    end
    context '日付を指定してない場合' do
      let(:datetime) { nil }
      it_behaves_like '400'
    end
    context '日付のフォーマットがおかしい場合' do
      let(:datetime) { '今日' }
      it_behaves_like '400'
    end
    context '日付が未来を示している場合' do
      let(:datetime) { (Time.zone.today + 1).to_s }
      it_behaves_like '400'
    end
    context 'メンバーに存在しないユーザを含んでいる場合' do
      let(:users) { [0] }
      it_behaves_like '400'
    end
  end
end
