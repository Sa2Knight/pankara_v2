require_relative '../../support/common_contexts'

RSpec.describe 'users#my_songs', type: :request do
  include_context 'request spec common'

  let(:user) { FactoryBot.create(:user) }
  let(:user_id) { user.id }
  let(:current_user) { user }
  let(:page)        { nil }
  let(:per)         { nil }
  let(:params) do
    {
      page: page,
      per: per
    }
  end
  let(:song) { FactoryBot.create(:song) }

  before do
    before_request if defined? before_request
    request(:get, "/api/users/#{user_id}/my_songs", params: params, user: current_user)
  end

  describe '正常系' do
    describe 'レスポンスボディの検証' do
      let(:before_request) do
        FactoryBot.create(:history, user: user, song: song)
      end

      subject { body.first.deep_symbolize_keys }

      it 'JSON構造が正しい' do
        is_expected.to include(
          :id,
          :artist_id,
          :name,
          :url,
          :histories_count,
          :histories_count_by_me
        )
      end
      it 'ステータスコードが200' do
        expect(status).to eq 200
      end
    end

    describe 'ページングの検証' do
      let(:user_event) { FactoryBot.create(:user_event, user: user) }
      let(:before_request) do
        Array.new(CONSTANT::DEFAULT::PER_PAGE + 1).each.with_index(1) do |_, n|
          FactoryBot.create(
            :history,
            user_event: user_event,
            song: FactoryBot.create(:song, name: n)
          )
        end
      end
      context '指定がない場合' do
        it '1件目から上限いっぱい取得できる' do
          expect(body.size).to eq CONSTANT::DEFAULT::PER_PAGE
          expect(body.first['name']).to eq '1'
          expect(body.last['name']).to eq CONSTANT::DEFAULT::PER_PAGE.to_s
        end
      end
      context 'per=2, page=2 の場合' do
        let(:per) { 2 }
        let(:page) { 2 }

        it '3,4件目が取得できる' do
          expect(body.size).to eq 2
          expect(body.first['name']).to eq '3'
          expect(body.last['name']).to eq '4'
        end
      end
    end

    describe 'その他の検証' do
      context '持ち歌が存在しない場合' do
        let(:before_request) do
          FactoryBot.create(:history, user: FactoryBot.create(:user))
        end
        subject { body }
        it { is_expected.to be_empty }
      end
    end
  end

  describe '異常系' do
    context 'ユーザが存在しない場合' do
      let(:user_id) { 0 }
      it_behaves_like '404'
    end
  end
end
