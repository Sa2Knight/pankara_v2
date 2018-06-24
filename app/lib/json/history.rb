module JSON
  module History
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
    def self.show(history)
      return nil if history.blank?
      {
        id: history.id,
        key: history.key,
        satisfaction: history.satisfaction,
        comment: history.comment,
        score: history.score,
        user: JSON::User.raw(history.user),
        event: JSON::Event.raw(history.event),
        song: JSON::Song.raw_with_artist(history.song),
        score_type: JSON::ScoreType.raw(history.score_type)
      }
    end
  end
end
