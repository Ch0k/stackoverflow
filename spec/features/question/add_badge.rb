require 'rails_helper'

feature 'User can add links to question', %q{
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
} do

  given!(:user) { create(:user) }
  given!(:question_with_badge) { create(:question, user: user) }
  given!(:badge) { create(:badge, user: user, question: question_with_badge) }
  given!(:answers) { create_list(:answer, 3, question: question_with_badge, user: user) }

  scenario 'User adds badge when asks question' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'
    within '.add_badge' do
      fill_in 'Badge name', with: 'My badge'
      attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb"]
    end
    click_on 'Ask'

    expect(page).to have_link 'rails_helper.rb'
  end

  scenario 'Author of question set best answer and user have badge' do
    sign_in(user)
    visit question_path(question_with_badge)
    within '.edit_question' do
      click_on 'Edit'
    end
    select(answers.last.body, :from => 'question[best_answer_id]')
    click_on 'Update question'
    expect(page).to have_content "Question updated"
    expect(page).to have_content answers.last.body
    visit badges_path
    expect(page).to have_content badge.name
  end
end
