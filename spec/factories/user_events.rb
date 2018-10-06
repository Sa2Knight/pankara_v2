FactoryBot.define do
  factory :user_event do
    user { FactoryBot.create(:user) }
    event { FactoryBot.create(:event) }
  end
end
