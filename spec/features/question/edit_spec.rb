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

    scenario 'User is a author edit question' do
      fill_in 'Title', with: 'new title'
      fill_in 'Body', with: 'new body'
      click_on 'Update question'
      expect(page).to have_content "Question updated"
    end


  end

  describe 'Authenticated user author of question' do
    given!(:question_with_file) { create(:question, :with_file, user: user) }

    scenario 'User is a author edit files in question' do
      sign_in(user)
      visit question_path(question_with_file)
      expect(page).to have_content question_with_file.title
      expect(page).to have_link 'test.txt'

      click_on 'Edit'

      attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]

      click_on 'Update question'
      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end

    scenario 'User is a author delete files in question' do
      sign_in(user)
      visit question_path(question_with_file)
      expect(page).to have_content question_with_file.title
      click_on 'Remove'
      expect(page).to_not have_link 'test.txt'
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

