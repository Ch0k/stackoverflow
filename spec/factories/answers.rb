FactoryBot.define do
  sequence :body do |n|
    "Answer test for body #{n}"
  end

  factory :answer do
    question
    user
    body

    trait :invalid do
      body { nil }
    end
  end
end
