require 'rails_helper'

feature 'User can edit question', %q{
  Only authenticated user can post questions
} do
  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  describe 'Authenticated user' do 
  
    background do
      sign_in(user)
      visit question_path(question)
      click_on 'Edit'
    end  

    scenario 'User edit question' do
      fill_in 'Title', with: 'new title'
      fill_in 'Body', with: 'new body'
      click_on 'Update question'
      expect(page).to have_content "Question updated"
    end

    scenario 'User edit question with errors' do
      fill_in 'Title', with: nil
      fill_in 'Body', with: 'new body'
      click_on 'Update question'
      expect(page).to have_content "detected"
    end
  end
  
  scenario 'Not authorizated user edit question' do
    visit question_path(question)
    click_on 'Edit'
    expect(page).to have_content "You need to sign in or sign up before continuing."
  end

end

