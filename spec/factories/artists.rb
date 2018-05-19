FactoryBot.define do
  factory :artist do
    name { SecureRandom.hex(6) }
  end
end
