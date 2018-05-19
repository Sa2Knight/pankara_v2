class Event < ApplicationRecord
  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events
  belongs_to :store,   optional: true
  belongs_to :product, optional: true

  #
  # 総歌唱履歴数を取得する
  # TODO: キャッシュしたい
  #
  def history_count
    History.where(user_event: self.user_events).size
  end
end
