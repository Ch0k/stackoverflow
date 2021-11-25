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


    #trait :with_file do
    #  title { "MyString" }
    #  body { "MyText" }

    #  after :create do |account|
    #    file_path = Rails.root.join('spec', 'support', 'assets', 'test-image.png')
    #    file = fixture_file_upload(file_path, 'image/png')
    #    question.files.attach(file)
    #  end
    #end
  end
end
