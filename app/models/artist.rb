class Artist < ApplicationRecord
  include CountableHistories

  has_many :songs, dependent: :destroy

  validates :name, length: { presence: false, minimum: 1, maximum: 80,
                             message: '歌手名は1~80文字にしてください' }

  scope :no_descriptions, -> { where(description: nil).or(where(url: nil)) }

  #
  # 歌手名で検索
  #
  def self.name_by(keyword)
    return self.all if keyword.blank?

    self.where("name like '%#{keyword}%'")
  end

  #
  # 曲名で検索
  # NOTE: この曲名は完全一致のみを対象とするので注意
  #
  def self.song_name_by(keyword)
    return self.all if keyword.blank?

    self.where(
      id: Song.where(name: keyword).pluck(:artist_id)
    )
  end

  #
  # 歌唱履歴
  # NOTE: has_manyだけで表現できる?
  #
  def histories
    History.where(song_id: self.songs.ids)
  end

  #
  # 特定ユーザの歌唱履歴
  #
  def histories_by(user: nil)
    return none if user.blank?

    self.histories.includes(:user).where(user_event: user.user_events)
  end

  #
  # 歌唱回数記録用のRedisキー
  #
  def redis_histories_count_key(user_id)
    "artist:#{self.id}:histories_count#{user_id}"
  end
end
