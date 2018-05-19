FactoryBot.define do
  factory :event do
    datetime { Util.random_datetime }
    title { SecureRandom.hex(20) }
    plan { [2, 3.5, 5, 7.5, 10].sample }
    store { Store.first }
    product { Product.first }
  end
end
