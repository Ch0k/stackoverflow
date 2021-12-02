FactoryBot.define do
  factory :badge do
    name { "MyString" }
    after :create do |badge|
      file = Rack::Test::UploadedFile.new('spec/factories/test.txt', 'text/plain') 
      badge.image.attach(file)
    end
  end
end
