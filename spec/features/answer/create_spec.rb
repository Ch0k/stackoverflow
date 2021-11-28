require 'rails_helper'

feature 'User can create answer', %q{
  To create a response
  As an authorized user
  I would like to ask an answer 
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answers) { create_list(:answer, 3, question: question, user: user) }

  describe 'Authenticated user' do

    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'create answer', js: true do
      expect(page).to have_content question.title
      expect(page).to have_content question.body
      answers.each do |answer|
        expect(page).to have_content answer.body
      end
      within '.new_answer' do
        fill_in 'Body', with: 'new answer answer answer'
        click_on 'Create answer'
      end
      expect(page).to have_content 'new answer answer answer'
    end

    scenario 'create answer with errors', js: true do
      expect(page).to have_content question.title
      expect(page).to have_content question.body
      answers.each do |answer|
        expect(page).to have_content answer.body
      end
      fill_in 'Body', with: 'new answer'
      click_on 'Create answer'
      expect(page).to have_content 'error'
    end

    scenario 'asks a question with attached file', js: true do
      
      within '.new_answer' do
        fill_in 'Body', with: 'new answer answer answer'
        attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
        click_on 'Create answer'
      end
      save_and_open_page
      within '.answers' do
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
    end
  end

  scenario 'Unauthenticated User not see link to create answer' do
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    answers.each do |answer|
      expect(page).to have_content answer.body
    end
    expect(page).to_not have_link 'Create answer'
  end
end
