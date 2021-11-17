require 'rails_helper'

feature 'User can edit question', %q{
  Only authenticated user and author of question can edit questions
} do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  describe 'Authenticated user author of question' do 
  
    background do
      sign_in(user)
      visit question_path(question)
      expect(page).to have_content question.title
      click_on 'Edit'
    end  

    scenario 'User author edit question' do
      fill_in 'Title', with: 'new title'
      fill_in 'Body', with: 'new body'
      click_on 'Update question'
      expect(page).to have_content "Question updated"
    end

    scenario 'User author edit question with errors' do
      fill_in 'Title', with: nil
      fill_in 'Body', with: 'new body'
      click_on 'Update question'
      expect(page).to have_content "detected"
    end
  end
  
  scenario 'Not authorizated user do not edit question' do
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to_not have_link "Edit"
  end

  scenario 'Not author of qestion do not edit question' do
    sign_in(another_user)
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to_not have_link "Edit"
  end

end

