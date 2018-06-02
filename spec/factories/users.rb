FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "TEST_NAME_#{n}" }
    sequence(:display_name) { |n| "TEST_DISPLAY_NAME_#{n}" }
    password { '1q2w3e4r' }
  end
end
