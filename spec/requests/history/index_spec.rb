require_relative '../../support/common_contexts'
RSpec.describe 'history#index', type: :request do
  include_context 'request spec common'

  # ログインユーザ
  let(:current_user) { FactoryBot.create(:user) }

  # リクエストパラメータ
  let(:song_id)     { nil }
  let(:artist_id)   { nil }
  let(:event_id)    { nil }
  let(:user_id)     { nil }
  let(:sort_key)    { nil }
  let(:sort_order)  { nil }
  let(:page)        { nil }
  let(:per)         { nil }
  let(:params) do
    {
      song_id: song_id,
      artist_id: artist_id,
      event_id: event_id,
      user_id: user_id,
      sort_key: sort_key,
      sort_order: sort_order,
      page: page,
      per: per
    }
  end

  before do
    before_request if defined? before_request
    request(:get, '/api/histories/', params: params, user: current_user)
  end

  describe 'レスポンスボディ' do
    let(:history) { FactoryBot.create(:history) }
    let(:before_request) { history }
    subject { body.first.deep_symbolize_keys }

    it do
      is_expected.to include(
        id: history.id,
        key: history.key,
        satisfaction: history.satisfaction,
        comment: history.comment,
        score: history.score,
        score_type: history.score_type,
        user: {
          id: history.user.id,
          display_name: history.user.display_name,
          image_url: history.user.image_url
        },
        event: {
          id: history.event.id,
          datetime: history.event.datetime.strftime(CONSTANT::FORMAT::DATE),
          title: history.event.title
        },
        song: {
          id: history.song.id,
          artist_id: history.song.artist_id,
          name: history.song.name,
          url: history.song.url,
          histories_count: 1,
          histories_count_by_me: 0,
          artist: {
            id: history.song.artist.id,
            name: history.song.artist.name,
            description: history.song.artist.description,
            url: history.song.artist.url
          }
        }
      )
    end
  end

  describe 'イベントによる絞り込み' do
    let(:event1) { FactoryBot.create(:event) }
    let(:event2) { FactoryBot.create(:event) }
    let(:before_request) do
      FactoryBot.create(:history, event: event1)
      FactoryBot.create(:history, event: event2)
    end

    context 'event1を指定した場合' do
      let(:event_id) { event1.id }
      it do
        expect(size).to eq 1
        expect(first['event']['title']).to eq event1.title
      end
    end
    context 'event2を指定した場合' do
      let(:event_id) { event2.id }
      it do
        expect(size).to eq 1
        expect(first['event']['title']).to eq event2.title
      end
    end
  end

  describe '楽曲による絞り込み' do
    let(:song1) { FactoryBot.create(:song) }
    let(:song2) { FactoryBot.create(:song) }
    let(:before_request) do
      FactoryBot.create(:history, song: song1)
      FactoryBot.create(:history, song: song2)
    end

    context 'song1を指定した場合' do
      let(:song_id) { song1.id }
      it do
        expect(size).to eq 1
        expect(first['song']['name']).to eq song1.name
      end
    end
    context 'song2を指定した場合' do
      let(:song_id) { song2.id }
      it do
        expect(size).to eq 1
        expect(first['song']['name']).to eq song2.name
      end
    end
  end

  describe '歌手による絞り込み' do
    let(:artist1) { FactoryBot.create(:artist) }
    let(:artist2) { FactoryBot.create(:artist) }
    let(:before_request) do
      FactoryBot.create(:history, artist: artist1)
      FactoryBot.create(:history, artist: artist2)
    end

    context 'artist1を指定した場合' do
      let(:artist_id) { artist1.id }
      it do
        expect(size).to eq 1
        expect(first['song']['artist']['name']).to eq artist1.name
      end
    end
    context 'artist2を指定した場合' do
      let(:artist_id) { artist2.id }
      it do
        expect(size).to eq 1
        expect(first['song']['artist']['name']).to eq artist2.name
      end
    end
  end

  describe 'ユーザによる絞り込み' do
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let(:before_request) do
      FactoryBot.create(:history, user: user1)
      FactoryBot.create(:history, user: user2)
    end
    context 'user1を指定した場合' do
      let(:user_id) { user1.id }
      it do
        expect(size).to eq 1
        expect(first['user']['id']).to eq user1.id
      end
    end
    context 'user2を指定した場合' do
      let(:user_id) { user2.id }
      it do
        expect(size).to eq 1
        expect(first['user']['id']).to eq user2.id
      end
    end
  end

  describe 'ページング関係' do
    let(:histories) { FactoryBot.create_list(:history, 5) }
    let(:before_request) { histories }
    subject { body.pluck('id') }

    context '指定しない場合' do
      it { is_expected.to eq histories.pluck(:id) }
    end

    context 'per=2, page=2 の場合' do
      let(:per) { 2 }
      let(:page) { 2 }

      it { is_expected.to eq [histories[2].id, histories[3].id] }
    end
  end

  describe 'ソート関係' do
    let(:histories) { FactoryBot.create_list(:history, 5) }
    let(:before_request) { histories }
    subject { body.pluck('id') }

    context 'sort_key=id, sort_order=desc の場合' do
      let(:sort_key) { 'id' }
      let(:sort_order) { 'desc' }

      it { is_expected.to eq histories.pluck(:id).reverse }
    end
  end

  describe '異常系' do
    # 今の所制限なし
  end
end
