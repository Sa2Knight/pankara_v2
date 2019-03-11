module JSON
  module Event
    #
    # Eventモデルの属性のみ
    #
    def self.raw(event)
      return nil if event.blank?
      {
        id: event.id,
        date: event.date.strftime(CONSTANT::FORMAT::DATE),
        title: event.title
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
    def self.show(event, current_user: nil)
      return nil if event.blank?

      self.raw(event).merge(
        history_size: event.history_count,
        max_score: event.max_score,
        average_score: event.average_score,
        average_satisfaction: event.average_satisfaction,
        can_edit: current_user ? event.editable_by?(user: current_user) : false,
        members: event.user_events.includes(:user).map do |user_event|
          {
            user: JSON::User.raw(user_event.user),
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
