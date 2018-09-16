module JSON
  module Event
    #
    # Eventモデルの属性のみ
    #
    def self.raw(event)
      return nil if event.blank?
      {
        id: event.id,
        datetime: event.datetime.strftime(CONSTANT::FORMAT::DATE),
        title: event.title,
      }
    end

    #
    # 一覧取得用
    #
    def self.index(event)
      return nil if event.blank?

      self.raw(event).merge(
        history_size: event.history_count,
        members: event.user_events.map do |user_event|
          JSON::User.raw(user_event.user)
        end
      )
    end

    #
    # 詳細取得用
    #
    def self.show(event)
      return nil if event.blank?

      history_dependents = [user_event: [:user], song: [:artist]]
      self.raw(event).merge(
        history_size: event.history_count,
        max_score: event.max_score,
        average_score: event.average_score,
        average_satisfaction: event.average_satisfaction,
        histories: event.histories.includes(history_dependents).map do |history|
          {
            id: history.id,
            user: JSON::User.raw(history.user_event.user), # HACK: ユーザIDだけでよくない？
            song: JSON::Song.raw_with_artist(history.song),
            score_type: history.score_type,
            score: history.score,
            satisfaction: history.satisfaction,
            key: history.key,
            comment: history.comment
          }
        end,
        members: event.user_events.includes(:user).map do |user_event|
          {
            user: JSON::User.raw(user_event.user),
            comment: user_event.comment,
            history_size: event.history_count(user_event: user_event),
            max_score: event.max_score(user_event: user_event),
            average_score: event.average_score(user_event: user_event),
            average_satisfaction: event.average_satisfaction(user_event: user_event)
          }
        end
      )
    end
  end
end
