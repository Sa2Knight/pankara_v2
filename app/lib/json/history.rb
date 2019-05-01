module JSON
  module History
    #
    # History及び関連レコードの情報を一通り揃えたオブジェクト
    # TODO: これだけで良いと思う
    #
    def self.make(history)
      return nil if history.blank?
      {
        id: history.id,
        key: history.key,
        satisfaction: history.satisfaction,
        comment: history.comment,
        score: history.score,
        score_type: history.score_type,
        user: JSON::User.raw(history.user),
        event: JSON::Event.raw(history.event),
        song: JSON::Song.raw_with_artist(history.song)
      }
    end

    #
    # Historyモデルの属性のみ
    #
    def self.raw(history)
      return nil if history.blank?
      {
        id: history.id,
        key: history.key,
        satisfaction: history.satisfaction,
        comment: history.comment,
        score: history.score,
        user: JSON::User.raw(history.user),
        event: JSON::Event.raw(history.event)
      }
    end

    #
    # History.show用
    #
    def self.show(history, current_user: nil)
      return nil if history.blank?
      {
        id: history.id,
        key: history.key,
        satisfaction: history.satisfaction,
        comment: history.comment,
        score: history.score,
        user: JSON::User.raw(history.user),
        event: JSON::Event.show(history.event, current_user: current_user),
        song: JSON::Song.raw_with_artist(history.song),
        score_type: history.score_type
      }
    end

    #
    # Artist.history用
    #
    def self.artist_index(history)
      return nil if history.blank?
      self.raw(history).merge(
        song: JSON::Song.raw(history.song)
      )
    end
  end
end
