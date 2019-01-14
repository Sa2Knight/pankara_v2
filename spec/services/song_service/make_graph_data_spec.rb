RSpec.describe 'SongService::MakeGraphData', type: :service do
  let(:song)    { FactoryBot.create(:song) }
  let(:service) { SongService::MakeGraphData.new(song) }

  before do
    # ユーザ作成
    user1 = FactoryBot.create(:user, display_name: 'ないと')
    user2 = FactoryBot.create(:user, display_name: 'ちゃら')

    # カラオケ作成
    event1 = FactoryBot.create(:event, datetime: Time.zone.parse('2017/05/01'))
    event2 = FactoryBot.create(:event, datetime: Time.zone.parse('2017/12/31'))
    event3 = FactoryBot.create(:event, datetime: Time.zone.parse('2018/04/04'))

    # 歌唱履歴作成
    FactoryBot.create(
      :history,
      user_event: FactoryBot.create(:user_event, user: user1, event: event1),
      song: song,
      score_type: 1,
      score: 90,
      satisfaction: 7
    )
    FactoryBot.create(
      :history,
      user_event: FactoryBot.create(:user_event, user: user2, event: event1),
      song: song,
      score_type: 1,
      score: 70,
      satisfaction: 7
    )
    FactoryBot.create(
      :history,
      user_event: FactoryBot.create(:user_event, user: user1, event: event2),
      song: song,
      score_type: 2,
      score: 88,
      satisfaction: 8
    )
    FactoryBot.create(
      :history,
      user_event: FactoryBot.create(:user_event, user: user1, event: event3),
      song: song,
      score_type: 2,
      score: 77,
      satisfaction: 5
    )
    FactoryBot.create(:history) # 関係ないHistoryを仕込んでおく
  end

  describe 'histories_by_month' do
    subject { service.send(:histories_by_month) }

    it '歌った年のみ含まれている' do
      expect(subject.key?(2016)).to be false
      expect(subject.key?(2017)).to be true
      expect(subject.key?(2018)).to be true
    end

    it '月ごとの歌った回数が含まれている' do
      expect(subject[2017][5 - 1]).to eq 2
      expect(subject[2017][12 - 1]).to eq 1
      expect(subject[2018][4 - 1]).to eq 1
    end

    it '歌った回数が0回の月も含まれている' do
      expect(subject[2017].size).to eq 12
      expect(subject[2017][4 - 1]).to be_zero
    end
  end

  describe 'satisfactions' do
    subject { service.send(:satisfactions) }

    it '満足度の回数が含まれている' do
      expect(subject[5 - 1]).to eq 1
      expect(subject[7 - 1]).to eq 2
      expect(subject[8 - 1]).to eq 1
    end

    it '回数が0の満足度も含まれている' do
      expect(subject.size).to eq 10
      expect(subject[2 - 1]).to be_zero
    end
  end

  describe 'scores_by_score_type' do
    subject { service.send(:scores_by_score_type) }

    it '最高点が含まれている' do
      expect(subject[:max][1 - 1]).to eq 90
      expect(subject[:max][2 - 1]).to eq 88
    end

    it '平均点が含まれている' do
      expect(subject[:avg][1 - 1]).to eq 80
      expect(subject[:avg][2 - 1]).to eq 82.5
    end

    it '特典情報がないものも含まれている' do
      expect(subject[:max].size).to eq 5
      expect(subject[:avg].size).to eq 5
      expect(subject[:avg][3 - 1]).to be_nil
    end
  end

  describe 'histories_by_user' do
    subject { service.send(:histories_by_user) }

    it 'ユーザ名が含まれてる' do
      expect(subject[:labels]).to match_array %w[ないと ちゃら]
    end
    it '歌唱回数が含まれている' do
      expect(subject[:data]).to match_array [3, 1]
    end
  end
end
