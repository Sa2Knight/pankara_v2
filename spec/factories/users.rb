FactoryBot.define do

  factory :user do
    sequence(:display_name) { |n| "TEST_NAME_#{n}" }
  end

end
