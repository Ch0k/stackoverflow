include ActionDispatch::TestProcess
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


    trait :with_file do
      title { "MyString with file" }
      body { "MyText with file" }
      after :create do |question|
        file = Rack::Test::UploadedFile.new('spec/factories/test.txt', 'text/plain') 
        question.files.attach(file)
      end
    end
  end
end
