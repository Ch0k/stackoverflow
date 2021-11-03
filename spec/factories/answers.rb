FactoryBot.define do
  factory :answer do
    association :question
    body { "MyText MyText MyText MyText" }
  end
end
