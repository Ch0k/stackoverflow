require 'rails_helper'

RSpec.describe User, type: :model do
  it {  should validate_presence_of :email  }
  it {  should validate_presence_of :password  }
  #it { is_expected.to be_author_of(Question) }

  #let!(:user) { create(:user) }
  #let(:question) { create(:question, user: user) } 
  #describe 'author_of?' do
  #  context 'be author' do
  #    it { is_expected.to be_author_of(question) }
  #  end

    #context 'be author' do
    #  before { question.user_id = user.id }
    #  it { is_expected.to be_author_of(question) }
    #end
  #end
end
