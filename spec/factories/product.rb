FactoryBot.define do
  factory :product do
    brand      { SecureRandom.hex(4) }
    name       { SecureRandom.hex(10) }
    full_name  { SecureRandom.hex(14) }
  end
end
