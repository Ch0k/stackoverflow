require 'rails_helper'

feature 'User and author of question can delete question', %q{
  Only the author of a question can delete a question
} do
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given(:another_user) { create(:user) }

  scenario 'User and author of question can delete question' do
    sign_in(user)
    visit question_path(question)
    expect(page).to have_content question.title
    click_on 'Delete question'
    expect(page).to have_content "Question deleted"
    expect(page).to_not have_content question.title
  end

  scenario 'User not owner not see link delete' do
    sign_in(another_user)
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to_not have_link "Delete question"    
  end


  scenario 'Unauthenticated user not see link delete' do
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to_not have_link "Delete question"    
  end
end

