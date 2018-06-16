class Event < ApplicationRecord
  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events
  has_many :histories, through: :user_events
  belongs_to :store,   optional: true
  belongs_to :product, optional: true

  #
  # タイトルで絞り込み
  #
  def self.title_like(title)
    return self.all if title.blank?

    self.where("title like '%#{title}%'")
  end

  #
  # 参加しているユーザで絞り込み
  #
  def self.by_member(*members)
    return self.all if members&.compact.blank?

    self.joins(:user_events)
        .where(user_events: { user_id: members })
  end

  #
  # 総歌唱履歴数を取得する
  # TODO: キャッシュしたい
  #
  def history_count
    self.histories.size
  end

  #
  # カラオケ内の最高得点を取得する
  # TODO: キャッシュしたい
  #
  def max_score
    self.histories.maximum(:score)
  end

  #
  # カラオケ内の平均得点を取得する
  # TODO: キャッシュしたい
  #
  def average_score
    self.histories.average(:score)
  end

  #
  # カラオケ内の平均得点を取得する
  # TODO: キャッシュしたい
  #
  def average_satisfaction
    self.histories.average(:satisfaction)
  end
end
