require_relative '../../support/common_contexts'

RSpec.describe 'events#index', type: :request do
  include_context 'request spec common'

  let(:title)       { nil }
  let(:members)     { nil }
  let(:sort_key)    { nil }
  let(:sort_order)  { nil }
  let(:page)        { nil }
  let(:per)         { nil }
  let(:params) do
    {
      title:       title,
      members:     members,
      sort_key:    sort_key,
      sort_order:  sort_order,
      page:        page,
      per:         per
    }
  end

  before do
    before_request if defined? before_request
    get '/api/events', params: params
  end

  describe 'シリアライズ関係' do
    context 'パラメータを指定しない場合' do
      let(:before_request) do
        FactoryBot.create_list(:event, 3)
      end

      it 'シリアライズされた結果が取得できる' do
        expect(status).to eq 200
        expect(size).to eq 3
        expect(Event.find(first['id'])).to eq Event.first
      end
    end
  end

  describe 'タイトル検索関係' do
    let(:before_request) do
      FactoryBot.create(:event, title: 'ABC')
      FactoryBot.create(:event, title: 'BCD')
      FactoryBot.create(:event, title: 'CDE')
    end
    context 'タイトルを指定しない場合' do
      let(:title) { '' }

      it '全件取得できる' do
        expect(size).to eq 3
      end
    end
    context 'タイトルに合致する曲がない場合' do
      let(:title) { 'F' }

      it '１件も取得できない' do
        expect(size).to eq 0
      end
    end
    context 'タイトルに合致する曲がある場合' do
      let(:title) { 'B' }

      it 'Bを含むタイトルのイベントが取得できる' do
        expect(size).to eq 2
        expect(body.first['title']).to eq 'ABC'
        expect(body.second['title']).to eq 'BCD'
      end
    end
  end

  describe '参加者一覧関係' do
    context '参加者が居ない場合' do
      let(:before_request) do
        FactoryBot.create(:event)
      end

      it 'membersが空になっている' do
        expect(first['members'].empty?).to be true
      end
    end
    context '参加者が一人の場合' do
      let(:before_request) do
        event = FactoryBot.create(:event)
        event.user_events.create(
          [
            { user: FactoryBot.create(:user, display_name: 'AAA') }
          ]
        )
      end

      it 'membersにユーザ情報が含まれている' do
        expect(first['members'].size).to eq 1
        expect(first['members'].first['display_name']).to eq 'AAA'
      end
    end
    context '参加者が二人の場合' do
      let(:before_request) do
        event = FactoryBot.create(:event)
        event.user_events.create(
          [
            { user: FactoryBot.create(:user, display_name: 'AAA') },
            { user: FactoryBot.create(:user, display_name: 'BBB') }
          ]
        )
      end

      it 'membersにユーザ情報が二人分含まれている' do
        expect(first['members'].size).to eq 2
        expect(first['members'].second['display_name']).to eq 'BBB'
      end
    end
  end

  describe '歌唱履歴数関係' do
    context '歌唱履歴が登録されていない場合' do
      let(:before_request) do
        event = FactoryBot.create(:event)
        event.user_events.create(
          [
            { user: FactoryBot.create(:user, display_name: 'AAA') }
          ]
        )
      end
      it '登録件数が0になる' do
        expect(first['history_size']).to eq 0
      end
    end
    context '歌唱履歴が登録されている場合' do
      let(:before_request) do
        event = FactoryBot.create(:event)
        user_events = event.user_events.create(
          [
            { user: FactoryBot.create(:user, display_name: 'AAA') }
          ]
        )
        FactoryBot.create_list(:history, 2, user_event: user_events.first)
      end
      it '登録件数が2になる' do
        expect(first['history_size']).to eq 2
      end
    end
  end

  describe 'ページング関係' do
    let(:before_request) do
      FactoryBot.create_list(:event, 5)
    end

    context '2件ずつ1ページ目を指定した場合' do
      let(:page) { 1 }
      let(:per)  { 2 }

      it '1件目と2件目が取得できる' do
        expect(size).to eq 2
        expect(body.first['id']).to eq Event.first.id
        expect(body.second['id']).to eq Event.second.id
      end
      it 'レスポンスヘッダにページング情報が含まれている' do
        expect(headers['total-count']).to eq 5
        expect(headers['total-pages']).to eq 3
      end
    end
    context '2件ずつ2ページ目を指定した場合' do
      let(:page) { 2 }
      let(:per)  { 2 }

      it '1件目と2件目が取得できる' do
        expect(size).to eq 2
        expect(body.first['id']).to eq Event.third.id
        expect(body.second['id']).to eq Event.fourth.id
      end
    end
    context '上限を超える件数を指定した場合' do
      let(:before_request) do
        FactoryBot.create_list(:event, 51)
      end
      let(:page) { 1 }
      let(:per)  { 51 }

      it '上限分のみ取得できる' do
        expect(size).to eq 50
      end
    end
  end

  describe 'ソート関係' do
    let(:before_request) do
      FactoryBot.create(:event, title: '2')
      FactoryBot.create(:event, title: '1')
      FactoryBot.create(:event, title: '3')
    end
    let(:sort_key) { 'title' }

    context '名前順昇順にした場合' do
      let(:sort_order) { 'asc' }

      it '名前が1,2,3の順に取得できる' do
        expect(body.first['id']).to  eq Event.second.id
        expect(body.second['id']).to eq Event.first.id
        expect(body.third['id']).to  eq Event.third.id
      end
    end
    context '名前順昇順にした場合' do
      let(:sort_order) { 'desc' }

      it '名前が3,2,1の順に取得できる' do
        expect(body.first['id']).to  eq Event.third.id
        expect(body.second['id']).to eq Event.first.id
        expect(body.third['id']).to  eq Event.second.id
      end
    end
  end
end
