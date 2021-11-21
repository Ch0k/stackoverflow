FactoryBot.define do
  factory :question do
    #association :best_answer, factory: :answer
    #answer { association :best_answer }
    user
    title { "MyString" }
    body { "MyText" }

    trait :invalid do
      title { nil }
    end
  end
end
