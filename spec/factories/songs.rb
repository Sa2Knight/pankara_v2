FactoryBot.define do
  factory :song do
    artist { FactoryBot.create(:artist) }
    name { SecureRandom.hex(6) }
    url  { SecureRandom.hex(8) }
  end
end
