FactoryBot.define do
  factory :artist do
    name { SecureRandom.hex(6) }
    description { SecureRandom.hex(128) }
    url { SecureRandom.hex(30) }
  end
end
