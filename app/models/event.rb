class Event < ApplicationRecord
  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events
  belongs_to :store,   optional: true
  belongs_to :product, optional: true

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
    History.where(user_event: self.user_events).size
  end
end
