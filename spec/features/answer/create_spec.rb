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

    scenario 'create answer' do
      expect(page).to have_content question.title
      expect(page).to have_content question.body
      answers.each do |answer|
        expect(page).to have_content answer.body
      end
      fill_in 'Body', with: 'new answer answer answer'
      click_on 'Create answer'
      expect(page).to have_content 'Answer successfuly created'
      expect(page).to have_content 'new answer answer answer'
    end

    scenario 'create answer with errors' do
      expect(page).to have_content question.title
      expect(page).to have_content question.body
      answers.each do |answer|
        expect(page).to have_content answer.body
      end
      fill_in 'Body', with: 'new answer'
      click_on 'Create answer'
      expect(page).to have_content 'error'
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
