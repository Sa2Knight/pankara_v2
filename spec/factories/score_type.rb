FactoryBot.define do
  factory :score_type do
    brand { SecureRandom.hex(4) }
    name  { SecureRandom.hex(10) }
  end
end
