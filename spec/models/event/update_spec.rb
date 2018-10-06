RSpec.describe Event, type: :model do
  let(:event) do
    FactoryBot.create(:event, datetime: DateTime.parse('2018/08/01'))
  end

  describe 'update' do
    let(:update_params) { {} }
    subject { event.update(update_params) }

    context '日付が更新された場合' do
      let!(:history) { FactoryBot.create(:history, event: event) }
      let(:update_params) { { datetime: DateTime.parse('2018/07/01') } }

      it '関連するHistoryの日付も更新される' do
        expect { subject }.to change { history.reload.event_date }
          .from(Date.parse('2018/08/01'))
          .to(Date.parse('2018/07/01'))
      end
    end
  end
end
