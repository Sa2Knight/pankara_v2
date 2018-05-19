FactoryBot.define do
  factory :user_event do
    user { FactoryBot.create(:user) }
    event { FactoryBot.create(:event) }
    price { Random.rand(500...5000) }
    comment { SecureRandom.hex(50) }
  end
end
