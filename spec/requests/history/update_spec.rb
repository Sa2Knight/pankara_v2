require_relative '../../support/common_contexts'
RSpec.describe 'history#update', type: :request do
  include_context 'request spec common'

  let(:params) do
    {
      event_id: history.event.id,
      user_id: user_id,
      song_name: history.song.name,
      artist_name: history.artist.name,
      comment: comment,
      key: 0
    }
  end
  let(:history) do
    FactoryBot.create(:history, user_event: user_event,
                                comment: '更新前', created_at: DateTime.yesterday)
  end
  let(:current_user) { FactoryBot.create(:user) }
  let(:event) { FactoryBot.create(:event) }
  let(:user_event) { FactoryBot.create(:user_event, user: current_user, event: event) }
  let(:history_id) { history.id }
  let(:user_id) { history.user.id }
  let(:comment) { '更新後' }

  subject do
    request(:patch, "/api/histories/#{history_id}", user: current_user, params: params)
  end

  describe '正常系' do
    it '歌唱履歴が更新される' do
      expect { subject }.to change { history.reload.comment }.from('更新前').to('更新後')
    end
    it '作成日時は変更されない' do
      created_at = history.created_at
      expect { subject }.not_to change { history.reload.created_at }.from(created_at)
    end
  end

  describe '異常系' do
    before { subject }

    context '歌唱履歴が存在しない場合' do
      let(:history_id) { 0 }
      it_behaves_like '404'
    end

    context 'カラオケに参加していない場合' do
      let(:user_id) { FactoryBot.create(:user).id }
      it_behaves_like '404'
    end

    context 'バリデーションエラーを起こした場合' do
      let(:comment) { 'a' * 256 }
      it_behaves_like '400'
    end
  end
end
