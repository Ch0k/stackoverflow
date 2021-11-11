require 'rails_helper'

feature 'User can see question', %q{
  the user can look at the questions to see body a question   
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answers) { create_list(:answer, 3, question: question, user: user) }

  scenario 'User see question and answers' do
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end

  scenario 'Authenticated User see question and answers and create answer' do
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

  end
end

