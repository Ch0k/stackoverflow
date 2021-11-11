FactoryBot.define do
  factory :answer do
    association :question
    association :user
    body { "MyText MyText MyText MyText" }

    trait :invalid do
      body { nil }
    end
  end
end
