FactoryBot.define do
  factory :event do
    datetime { Util.random_datetime }
    title    { SecureRandom.hex(20) }
  end
end
