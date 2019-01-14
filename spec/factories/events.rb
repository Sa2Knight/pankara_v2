FactoryBot.define do
  factory :event do
    date { Util.random_datetime }
    title { SecureRandom.hex(12) }
    user { FactoryBot.create(:user) }
  end
end
