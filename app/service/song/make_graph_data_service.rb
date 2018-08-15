#
# 楽曲詳細画面で表示する各種グラフ用のデータを生成するサービス
# TODO: まず動くものを最低限作ったのでテスト書いたらリファクタリング
# TODO: マジックナンバー殺す
# TODO: rubocopそれなりに従う
# TODO: 非常に高コストになるのでRedisキャッシュ必須
#
class Song::MakeGraphDataService
  def initialize(song)
    raise ArgumentError unless song.is_a?(Song)

    @song = song
    @histories = song.histories.includes(user_event: %i[user event])
  end

  def perform
    {
      histories_by_month:   histories_by_month,
      satisfactions:        satisfactions,
      scores_by_score_type: scores_by_score_type,
      histories_by_user:    histories_by_user
    }
  end

  private

    #
    # 月ごとの歌唱回数
    #
    def histories_by_month
      results = Hash.new do |h1, year|
        h1[year] = Hash.new do |h2, month|
          h2[month] = 0
        end
      end

      @histories.all.each do |history|
        year  = history.event.datetime.year
        month = history.event.datetime.month
        results[year][month] += 1
      end

      results.keys.reduce({}) do |ac, year|
        ac[year] = Util.number_key_hash_to_array(results[year], max: 11, offset: 1)
        ac
      end
    end

    #
    # 満足度のレート
    #
    def satisfactions
      satisfaction_count_hash = @histories.satisfied.group(:satisfaction).count
      Util.number_key_hash_to_array(
        satisfaction_count_hash,
        max: 9,
        offset: 1,
        default: 0
      )
    end

    #
    # 得点情報
    #
    def scores_by_score_type
      max_results = @histories.scored.group(:score_type).maximum(:score)
      avg_results = @histories.scored.group(:score_type).average(:score)
      {
        max: Util.number_key_hash_to_array(max_results, max: 4, offset: 1),
        avg: Util.number_key_hash_to_array(avg_results, max: 4, offset: 1)
      }
    end

    #
    # ユーザ別歌唱回数
    #
    def histories_by_user
      @histories.joins(:user_event, :user).group(:display_name).count
    end
end
