require_relative '../../support/common_contexts'
RSpec.describe 'songs#histories', type: :request do
  include_context 'request spec common'

  let(:user) { FactoryBot.create(:user) }
  let(:song) { FactoryBot.create(:song) }
  let(:user_event) { FactoryBot.create(:user_event, user: user) }

  let(:song_id)     { song.id }
  let(:user_id)     { nil }
  let(:sort_key)    { nil }
  let(:sort_order)  { nil }
  let(:page)        { nil }
  let(:per)         { nil }
  let(:params) do
    {
      user_id:     user_id,
      sort_key:    sort_key,
      sort_order:  sort_order,
      page:        page,
      per:         per
    }
  end

  before do
    before_request if defined? before_request
    request(:get, "/api/songs/#{song_id}/histories", params: params, user: user)
  end

  describe 'シリアライズ関係' do
    let(:before_request) { FactoryBot.create(:history, user_event: user_event, song: song) }

    describe 'History' do
      it '歌唱履歴情報が取得できる' do
        history = History.first
        expect(status).to eq 200
        expect(first['id']).to eq history.id
        expect(first['satisfaction']).to eq history.satisfaction
      end
    end
    describe 'User' do
      it '歌唱履歴を登録したユーザが取得できる' do
        user = User.first
        expect(first['user']['id']).to eq user.id
        expect(first['user']['display_name']).to eq user.display_name
      end
    end
    xdescribe 'Event' do
      let(:event) { first['event'] }
    end
  end

  describe 'ユーザ絞り込み関係' do
    let(:before_request) do
      FactoryBot.create_list(:history, 3, user_event: user_event, song: song)
      FactoryBot.create_list(:history, 3, user_event: FactoryBot.create(:user_event), song: song)
    end

    context '絞り込みがない場合' do
      let(:user_id) { nil }
      it '全件取得できる' do
        expect(size).to eq 6
      end
    end
    context '特定ユーザで絞った場合' do
      let(:user_id) { user.id }
      it '特定ユーザののみ取得できる' do
        expect(size).to eq 3
        body.each do |history|
          expect(history['user']['id']).to eq user_id
        end
      end
    end
  end

  describe 'ページング関係' do
    let(:before_request) do
      FactoryBot.create_list(:history, 5, user_event: user_event, song: song)
    end

    context '2件ずつ1ページ目を指定した場合' do
      let(:page) { 1 }
      let(:per)  { 2 }

      it '1件目と2件目が取得できる' do
        expect(size).to eq 2
        expect(body.first['id']).to eq History.first.id
        expect(body.second['id']).to eq History.second.id
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
        expect(body.first['id']).to eq History.third.id
        expect(body.second['id']).to eq History.fourth.id
      end
    end
    context '上限を超える件数を指定した場合' do
      let(:before_request) do
        FactoryBot.create_list(:history, 51, user_event: user_event, song: song)
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
      FactoryBot.create(:history, user_event: user_event, song: song, key: -2, score: 40)
      FactoryBot.create(:history, user_event: user_event, song: song, key: 6,  score: 70)
      FactoryBot.create(:history, user_event: user_event, song: song, key: 0,  score: 90)
    end
    context 'キー昇順にした場合' do
      let(:sort_key) { 'key' }
      let(:sort_order) { 'asc' }

      it 'キーが-2,0,6の順に取得できる' do
        expect(body.first['id']).to  eq History.first.id
        expect(body.second['id']).to eq History.third.id
        expect(body.third['id']).to  eq History.second.id
      end
    end
    context '得点降順にした場合' do
      let(:sort_key) { 'score' }
      let(:sort_order) { 'desc' }

      it '名前が3,2,1の順に取得できる' do
        expect(body.first['id']).to  eq History.third.id
        expect(body.second['id']).to eq History.second.id
        expect(body.third['id']).to  eq History.first.id
      end
    end
  end

  describe '異常系' do
    context '楽曲が存在しない場合' do
      let(:song_id) { 0 }
      it_behaves_like '404'
    end
  end
end
