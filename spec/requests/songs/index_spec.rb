require_relative '../../support/common_contexts'

RSpec.describe 'songs#index', type: :request do
  include_context 'request spec common'

  let(:current_user) { FactoryBot.create(:user) }
  let(:with_artist) { nil }
  let(:user_id)     { nil }
  let(:artist_id)   { nil }
  let(:artist_name) { nil }
  let(:name)        { nil }
  let(:sort_key)    { nil }
  let(:sort_order)  { nil }
  let(:page)        { nil }
  let(:per)         { nil }
  let(:params) do
    {
      with_artist: with_artist,
      user_id: user_id,
      artist_id: artist_id,
      artist_name: artist_name,
      name: name,
      sort_key: sort_key,
      sort_order: sort_order,
      page: page,
      per: per
    }
  end
  let(:artist) { FactoryBot.create(:artist) }

  before do
    before_request if defined? before_request
    request(:get, '/api/songs/', params: params, user: current_user)
  end

  describe 'シリアライズ関係' do
    let(:before_request) { FactoryBot.create_list(:song, 3, artist: artist) }

    context '歌手情報を指定しなかった場合' do
      let(:with_artist) { nil }

      it '歌手情報を含まずにシリアライズされた結果を取得できる' do
        expect(status).to eq 200
        expect(size).to eq Song.count
        expect(first.key?('artist')).to be false
        expect(Song.find(first['id'])).to eq Song.first
      end
    end
    context '歌手情報を指定した場合' do
      let(:with_artist) { 1 }

      it '歌手情報を含んでシリアライズされた結果を取得できる' do
        expect(first.key?('artist')).to be true
        expect(first['artist']['name']).to eq artist.name
        expect(Artist.find(first['artist']['id'])).to eq artist
      end
    end
  end

  describe '絞り込み関係' do
    let(:before_request) do
      artist_a = FactoryBot.create(:artist, name: '123')
      artist_b = FactoryBot.create(:artist, name: '456')
      FactoryBot.create(:song, name: 'AAA', artist: artist_a)
      FactoryBot.create(:song, name: 'BBB', artist: artist_b)
      FactoryBot.create(:song, name: 'ABC', artist: artist_b)
    end

    context '歌手IDを指定した場合' do
      let(:artist_id) { Artist.second.id }

      it 'artist_2の楽曲のみ取得できる' do
        expect(size).to eq 2
        expect(body.first['name']).to eq 'BBB'
        expect(body.second['name']).to eq 'ABC'
      end
    end
    context '歌手名を指定した場合' do
      let(:artist_name) { '2' }

      it 'artist_1の楽曲のみ取得できる' do
        expect(size).to eq 1
        expect(body.first['name']).to eq 'AAA'
      end
    end
    context '名前を指定した場合' do
      let(:name) { 'A' }

      it '曲名にAが含まれる楽曲のみ取得できる' do
        expect(size).to eq 2
        expect(body.first['name']).to eq 'AAA'
        expect(body.second['name']).to eq 'ABC'
      end
    end
    context '歌手IDと名前両方指定した場合' do
      let(:name) { 'A' }
      let(:artist_id) { Artist.last.id }

      it '名前と歌手ID両方に合致する楽曲のみ取得できる' do
        expect(size).to eq 1
        expect(body.first['name']).to eq 'ABC'
      end
    end
    context 'ユーザIDを指定した場合' do
      let(:user) { FactoryBot.create(:user) }
      let(:user_id) { user.id }

      context '歌唱履歴がない場合' do
        it '何も取得しない' do
          expect(size).to be_zero
        end
      end

      context '歌唱履歴がある場合' do
        let(:before_request) do
          song_a = FactoryBot.create(:song, name: 'AAA')
          song_b = FactoryBot.create(:song, name: 'BBB')
          FactoryBot.create(:history, song: song_a, user: user)
          FactoryBot.create(:history, song: song_b, user: FactoryBot.create(:user))
        end
        it 'ユーザの持ち歌のみ取得できる' do
          expect(size).to eq 1
          expect(body.first['name']).to eq 'AAA'
        end
      end
    end
  end

  describe 'ページング関係' do
    let(:before_request) do
      FactoryBot.create_list(:song, 5, artist: FactoryBot.create(:artist))
    end

    context '2件ずつ1ページ目を指定した場合' do
      let(:page) { 1 }
      let(:per)  { 2 }

      it '1件目と2件目が取得できる' do
        expect(size).to eq 2
        expect(body.first['id']).to eq Song.first.id
        expect(body.second['id']).to eq Song.second.id
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
        expect(body.first['id']).to eq Song.third.id
        expect(body.second['id']).to eq Song.fourth.id
      end
    end
    context '上限を超える件数を指定した場合' do
      let(:before_request) do
        stub_const('CONSTANT::CAP::PER_PAGE', 3)
        FactoryBot.create_list(:song, 4, artist: FactoryBot.create(:artist))
      end
      let(:page) { 1 }
      let(:per)  { 4 }

      it '上限分のみ取得できる' do
        expect(size).to eq 3
      end
    end
  end

  describe 'ソート関係' do
    let(:before_request) do
      artist = FactoryBot.create(:artist)
      FactoryBot.create(:song, name: '2', artist: artist)
      FactoryBot.create(:song, name: '1', artist: artist)
      FactoryBot.create(:song, name: '3', artist: artist)
    end
    let(:sort_key) { 'name' }

    context '名前順昇順にした場合' do
      let(:sort_order) { 'asc' }

      it '名前が1,2,3の順に取得できる' do
        expect(body.first['id']).to  eq Song.second.id
        expect(body.second['id']).to eq Song.first.id
        expect(body.third['id']).to  eq Song.third.id
      end
    end
    context '名前順昇順にした場合' do
      let(:sort_order) { 'desc' }

      it '名前が3,2,1の順に取得できる' do
        expect(body.first['id']).to  eq Song.third.id
        expect(body.second['id']).to eq Song.first.id
        expect(body.third['id']).to  eq Song.second.id
      end
    end
  end
end
