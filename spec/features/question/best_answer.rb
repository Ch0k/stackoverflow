require 'rails_helper'

feature 'User can create best answer', %q{
  the user author of question select best answer for question   
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answers) { create_list(:answer, 3, question: question, user: user) }
  
  scenario 'User see link to edit question' do
    sign_in(user)
    visit question_path(question)
    expect(page).to have_link "Edit"
  end

  scenario 'User select best answer for quesiton' do
    sign_in(user)
    visit question_path(question)
    within '.edit_question' do
      click_on 'Edit'
    end
    select(answers.last.body, :from => 'question[best_answer_id]')
    click_on 'Update question'
    expect(page).to have_content "Question updated"
    expect(page).to have_content answers.last.body
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
#<select name="question[best_answer_id]" id="question_best_answer_id"><option selected="selected" value="13">sdfs d sdf sdf  sdf </option>
#<option value="14">sdfsdfsd fsdf df sfd sd </option></select>
