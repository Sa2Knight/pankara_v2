class Song < ApplicationRecord
  belongs_to :artist

  #
  # ArtistIDで絞り込み
  #
  def self.artist_by(artist_id)
    return self.all if artist_id.blank?
    self.where(artist_id: artist_id)
  end

  #
  # キーワードで絞り込み
  #
  def self.name_by(keyword)
    return self.all if keyword.blank?
    self.where("name like '%#{keyword}%'")
  end

  #
  # 歌唱回数を取得する
  # NOTE: これもカウンターキャッシュあっても良いかも？
  #
  def history_count
    History.where(song: self).size
  end

  #
  # 特定ユーザの歌唱回数を取得する
  # NOTE: これもどうにかキャッシュしたい
  #
  def history_count_by(user: nil)
    return nil if user.blank?
    History.joins(:user_event)
           .where(song: self, user_events: { user: user })
           .size
  end
end
