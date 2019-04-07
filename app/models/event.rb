class Event < ApplicationRecord
  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events
  has_many :histories, through: :user_events
  belongs_to :user

  validates :title, length: { maximum: 24, message: 'タイトルは24文字までです' }

  include ActiveModel::Validations
  validates_with EventValidators

  #
  # カラオケ作成後、作成者を参加させる
  #
  after_create do
    self.user_events.create(user_id: self.user_id)
  end

  #
  # カラオケ更新後、歌唱履歴の日付を更新する
  # TODO: dateが更新された場合のみ発火で良いと思う
  #
  after_update do
    self.histories.update(event_date: self.date)
  end

  #
  # タイトルで絞り込み
  #
  def self.title_like(title)
    return self.all if title.blank?

    self.where("title like '%#{title}%'")
  end

  #
  # 参加しているユーザで絞り込み
  # 複数指定がある場合はOR検索
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

  #
  # 指定したユーザで編集可能か？
  # 現状はカラオケ参加者全員可能
  #
  def editable_by?(user:)
    self.user_events.exists?(user: user)
  end
end
