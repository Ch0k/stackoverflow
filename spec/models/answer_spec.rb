require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'associations' do 
    it {  should belong_to(:question)  }
  end
  
  describe 'validations' do 
    it {  should validate_presence_of :body }
    it {  should validate_length_of(:body).is_at_least(15)}
  end

  describe 'db_index' do
    it { should have_db_index(:question_id) }
  end

  it { should accept_nested_attributes_for :links }
  it { should have_many(:links).dependent(:destroy) }

  it 'have many attached files' do
    expect(Answer.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
  end 
end
