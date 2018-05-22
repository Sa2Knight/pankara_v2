FactoryBot.define do
  factory :store do
    name { SecureRandom.hex(15) }
    branch { SecureRandom.hex(10) }
  end
end
