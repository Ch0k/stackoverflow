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

    trait :with_file do
      body { "MyText with file" }
      after :create do |answer|
        file = Rack::Test::UploadedFile.new('spec/factories/test.txt', 'text/plain') 
        answer.files.attach(file)
      end
    end
  end
end
