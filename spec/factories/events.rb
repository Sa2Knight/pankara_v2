FactoryBot.define do
  factory :event do
    datetime { Util.random_datetime }
    title    { SecureRandom.hex(20) }
    product do
      Product.none? ? FactoryBot.create(:product) : Product.first
    end
  end
end
