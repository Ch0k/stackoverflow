require 'rails_helper'

feature 'User and author of answer can delete answer', %q{
  Only the author of a answer can delete a answer
} do
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }
  given(:another_user) { create(:user) }
  
  scenario 'User and author can delete answer' do
    sign_in(user)
    visit question_path(question)
    expect(page).to have_content answer.body
    click_on 'Delete answer'
    expect(page).to have_content "Answer deleted"
    expect(page).to_not have_content answer.body
  end

  scenario 'User not owner not see link delete' do
    sign_in(another_user)
    visit question_path(question)
    expect(page).to have_content answer.body
    expect(page).to_not have_link "Delete answer"    
  end

  scenario 'Unauthenticated user not see link delete' do
    visit question_path(question)
    expect(page).to have_content answer.body
    expect(page).to_not have_link "Delete answer"    
  end
end

