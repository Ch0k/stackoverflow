require 'rails_helper'

feature 'User can create question', %q{
  In a order to get answer from a community
  As an autenticated user
  I'd like to be able to ask the question    
} do

  given(:user) { create(:user) }

  describe 'Authenticated user' do 
  
    background do
      sign_in(user)
      visit questions_path
      click_on 'Ask question'
    end

    scenario 'successfuly create question' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'Text text text'
      click_on 'Ask'

      expect(page).to have_content 'Test question'
      expect(page).to have_content 'Text text text'
    end

    scenario 'unsuccessfuly create question with errors' do
      click_on 'Ask'
      expect(page).to have_content "Title can't be blank"
    end

    scenario 'asks a question with attached file' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'

      attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Ask'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
  end

  scenario 'Unauthenticated user tries to create question' do
    visit questions_path
    click_on 'Ask question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  context 'mulitple sessions', js: true do
    scenario "question appears on another user's page" do
      Capybara.using_session('second_user') do
        second_user = create(:user)

        sign_in(second_user)
        visit questions_path
      end

      Capybara.using_session('user') do
        sign_in(user)
        visit questions_path

        click_on 'Ask question'
        fill_in 'Title', with: 'Question title'
        fill_in 'Body', with: 'Question body'
        click_on 'Ask'

        expect(page).to have_content 'Question title'
        expect(page).to have_content 'Question body'
      end

      Capybara.using_session('second_user') do
        expect(page).to have_content 'Question title'
      end
    end
  end
end
