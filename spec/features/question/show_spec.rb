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

  scenario 'User see best answer' do
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    expect(page).to have_content question.best_answer
    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end
end

