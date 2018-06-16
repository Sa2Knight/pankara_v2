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
        plan: event.plan,
        store: JSON::Store.raw(event.store),
        product: JSON::Product.raw(event.product)
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

      self.raw(event).merge(
        history_size: event.history_count,
        max_score: event.max_score,
        average_score: event.average_score,
        average_satisfaction: event.average_satisfaction,
        histories: event.histories.includes(:user_event, song: [:artist]).map do |history|
          {
            user_id: history.user_event.user_id,
            song: JSON::Song.raw_with_artist(history.song),
            score_type: JSON::ScoreType.raw(history.score_type),
            score: history.score,
            satisfaction: history.satisfaction,
            key: history.key,
            comment: history.comment
          }
        end,
        members: event.user_events.includes(:user).map do |user_event|
          {
            user: JSON::User.raw(user_event.user),
            price: user_event.price,
            comment: user_event.comment
          }
        end
      )
    end
  end
end
