module JSON
  module Event
    #
    # Eventモデルの属性のみ
    #
    def self.raw(event)
      return nil if event.blank?
      {
        id: event.id,
        datetime: event.datetime.strftime(CONSTANT::FORMAT::DATE_TIME),
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
        members: event.users.map do |user|
          JSON::User.raw(user)
        end
      )
    end
  end
end
