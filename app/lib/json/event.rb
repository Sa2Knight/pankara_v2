module JSON
  module Event
    def self.generate(event)
      return nil if event.blank?
      {
        datetime: event.datetime.strftime(CONSTANT::FORMAT::DATE_TIME),
        title: event.title,
        plan: event.plan,
        store: JSON::Store.generate(event.store),
        product: JSON::Product.generate(event.product),
        history_size: 0, # TODO: カウンターキャッシュ?
        members: event.users.map do |user|
          JSON::User.generate(user)
        end
      }
    end
  end
end
