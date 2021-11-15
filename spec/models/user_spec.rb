require 'rails_helper'

RSpec.describe User, type: :model do
  it {  should validate_presence_of :email  }
  it {  should validate_presence_of :password  }
  it { should have_many :questions }

  describe 'author_of?' do
    let(:user) { create(:user) }
    let(:any_user) { create(:user) }

    it 'user is an author' do
      question = create(:question, user: user)
      expect(user).to be_author_of(question)
    end

    it 'user not an author' do
      question = create(:question, user: any_user)
      expect(user).to_not be_author_of(question)
    end
  end
end
