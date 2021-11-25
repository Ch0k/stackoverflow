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
      #file { fixture_file_upload(Rails.root.join('spec', 'rails_helper.rb'), 'rails_helper/rb') }
      after :create do |question|
        file = Rack::Test::UploadedFile.new('spec/factories/test.txt', 'text/plain') 
        question.files.attach(file)
      end
        #after :create do 
      #end
        #after :create do |question|
        #file_path = Rails.root.join('spec', 'support', 'controller_helpers.rb')
        #file = file_fixture_path(file_path, 'application/x-ruby')
      #  question.files.attach(file)
      #end
    end
  end
end
