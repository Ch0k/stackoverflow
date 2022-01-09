require 'rails_helper'

feature 'User can add unvote to question' do

  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:author_answer) { create(:answer, user: author, question: question) }
  given!(:answer) { create(:answer, user: user, question: question) }

  scenario 'User can not add unvote to self question' do
    sign_in(author)
    visit question_path(question)
    expect(page).to_not have_link(href: unvote_answer_path(author_answer))
    expect(page).to have_link(href: unvote_answer_path(answer))
  end

  scenario 'User add unvote to another question', js: true do
    sign_in(author)
    visit question_path(question)
    click_link 'unvoting'
    within '.new-rating' do
      expect(page).to have_content "-1"
    end
  end

  scenario 'User can not add unvote if answer have vote', js: true do
    sign_in(author)
    visit question_path(question)
    click_link 'voting'
    within '.new-rating' do
      expect(page).to have_content "1"
    end
    expect(page).to_not have_link(href: unvote_answer_path(question))
  end
end
