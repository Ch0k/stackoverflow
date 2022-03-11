require 'rails_helper'

feature 'User can edit his answer', %q{
  In order to correct mistakes
  As an author of answer
  I'd like ot be able to edit my answer
} do

  given!(:user) { create(:user) }
  given!(:another_user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  describe 'Unauthenticated can not edit answer' do
    given!(:answer) { create(:answer, question: question, user: user) }
    scenario 'Unauthenticated can not edit answer' do
      visit question_path(question)

      expect(page).to_not have_link 'Edit'
    end
  end
  describe 'Authenticated user' do
    given!(:answer) { create(:answer, question: question, user: user) }

    scenario 'edits his answer', js: true do
      sign_in(user)
      visit question_path(question)

      within '.answers' do
        click_on 'Edit' 
      end

      within '.edit_answer' do
        fill_in 'Body', with: 'edited answer answer'
        click_on 'Update answer'
      end
      expect(page).to have_content 'edited answer answer'
    end

    scenario 'edits his answer with errors', js: true do 
      sign_in(user)
      visit question_path(question)
      within '.answers' do
        click_on 'Edit' 
      end

      within '.edit_answer' do
        fill_in 'Body', with: 'edited answer edted answer'
        click_on 'Update answer'
      end  
        expect(page).to have_content answer.body
      end

    scenario "tries to edit other user's question" do 
      sign_in(another_user)
      visit question_path(question)
      within '.answers' do
        expect(page).to_not have_link 'Edit'
      end
    end
  end

  describe 'Authenticated user edit answer with files' do
    given!(:answer_with_file) { create(:answer, :with_file, question: question, user: user) }
    
    scenario 'edit file in his answer ', js: true do
      sign_in(user)
      visit question_path(question)
      within '.answers' do
        click_on 'Edit' 
      end

      within '.edit_answer' do
        attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]

        click_on 'Update answer'
      end
      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end

    scenario 'delete file in his answer', js: true do
      sign_in(user)
      visit question_path(question)
      within '.answers' do
        click_on 'Edit' 
        expect(page).to have_link 'test.txt'
      end
      within '.edit_answer' do
        accept_alert do
          click_on 'Remove'
        end
      end

      expect(page).to_not have_link 'test.txt'
    end
  end
end
