require 'rails_helper'

feature 'User can see question', %q{
  the user can look at the questions to see body a question   
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answers) { create_list(:answer, 3, question: question, user: user) }

  
  scenario 'User see question and answers' do
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end

  scenario 'Authenticated User create answer' do
    sign_in(user)
    visit question_path(question)
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

  scenario 'Authenticated User create answer with errors' do
    sign_in(user)
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    answers.each do |answer|
      expect(page).to have_content answer.body
    end
    fill_in 'Body', with: 'new answer'
    click_on 'Create answer'
    expect(page).to have_content 'error'
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

