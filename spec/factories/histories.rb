FactoryBot.define do
  factory :history do
    transient do
      user  { FactoryBot.create(:user) }
      event { FactoryBot.create(:event) }
    end

    user_event   { FactoryBot.create(:user_event, event: event, user: user) }
    song         { FactoryBot.create(:song) }
    score        { Random.rand(0..100) }
    satisfaction { Random.rand(1..10) }
    key          { Random.rand(-7..7) }
    comment      { SecureRandom.hex(20) }
    score_type { Random.rand(1..5) }

    after(:create) do |history|
      history.update(event_date: history.event.datetime)
    end
  end
end
