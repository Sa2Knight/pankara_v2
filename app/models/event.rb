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
  #
  def history_count(user_event: nil)
    self.histories.by_user_event(user_event).size
  end

  #
  # カラオケ内の最高得点を取得する
  #
  def max_score(user_event: nil)
    self.histories.by_user_event(user_event).maximum(:score)
  end

  #
  # カラオケ内の平均得点を取得する
  #
  def average_score(user_event: nil)
    self.histories.by_user_event(user_event).average(:score)
  end

  #
  # カラオケ内の平均得点を取得する
  #
  def average_satisfaction(user_event: nil)
    self.histories.by_user_event(user_event).average(:satisfaction)
  end
end
