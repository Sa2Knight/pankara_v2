FactoryBot.define do
  factory :event do
    datetime { Util.random_datetime }
    title    { SecureRandom.hex(20) }
    plan     { [2, 3.5, 5, 7.5, 10].sample }
    product do
      Product.none? ? FactoryBot.create(:product) : Product.first
    end
  end
end
