class History < ApplicationRecord
  belongs_to :user_event
  belongs_to :song

  has_one :user,   through: :user_event
  has_one :event,  through: :user_event
  has_one :artist, through: :song

  scope :by_user_event, lambda { |user_event|
    user_event.present? ? where(user_event: user_event) : self
  }
  scope :scored, -> { where.not(score: nil) }
  scope :satisfied, -> { where.not(satisfaction: nil) }

  #
  # イベントIDで絞り込み
  #
  def self.by_event(event_id)
    return all if event_id.blank?
    where(user_event: UserEvent.where(event_id: event_id))
  end

  #
  # 楽曲IDで絞り込み
  #
  def self.by_song(song_id)
    return all if song_id.blank?
    where(song: song_id)
  end

  #
  # 歌手IDで絞り込み
  #
  def self.by_artist(artist_id)
    return all if artist_id.blank?
    self.where(song: Song.where(artist_id: artist_id))
  end

  #
  # ユーザIDで絞り込み
  #
  def self.by_user_id(user_id)
    return all if user_id.blank?
    where(user_event: UserEvent.where(user_id: user_id))
  end

  # mock
  def comment
    super || [
      'このキーが一番歌いやすいcs',
      'ガチで楽しかった',
      '難しいなぁこの曲、練習あるのみだ',
      '楽しい',
      'もうちょっとキーあげても行ける気がする',
      'ラップ部分がどうしようもなくてワロタ',
      'Aさんと一緒に。ハモってくれると嬉しいなぁ。',
      '全然だめだった',
      '悪くはないんだけど、どうしてもサビがつらすぎる',
      'メロとサビで高低差が大きいせいで音程が安定しないのが問題',
      '久々に歌ったけどこんな楽しかったっけ',
      'なんかもう楽しすぎてやばい',
      '間奏が長すぎて暇',
      'サビ以外がうろ覚えすぎてどうしようもないわｗｗｗ',
      '唐突なCメロやめーや',
      'アニメ映像あると思ったけどないの？',
      'もうちょっと練習が必要そう',
      '気持ち的には95点は行ったんだけどなぁ',
      '糞曲',
      '神曲',
      'たまにはこういうジャンルも良いよね。',
      '最高に盛り上がった'
    ].sample
  end
end
