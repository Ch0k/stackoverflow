require 'rails_helper'

feature 'User can add vote and to question' do

  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given!(:author_question) { create(:question, user: author) }
  given!(:question) { create(:question, user: user) }

  scenario 'User can not add vote to self question' do
    sign_in(author)
    visit questions_path
    expect(page).to_not have_link(href: vote_question_path(author_question))
    expect(page).to have_link(href: vote_question_path(question))
  end

  scenario 'User add vote to another question', js: true do
    sign_in(author)
    visit questions_path
    click_link 'voting'
    within '.new-rating' do
      expect(page).to have_content "1"
    end
  end

  scenario 'User can not add vote if question have unvote', js: true do
    sign_in(author)
    visit questions_path
    click_link 'unvoting'
    within '.new-rating' do
      expect(page).to have_content "-1"
    end
    save_and_open_page
    expect(page).to_not have_link(href: vote_question_path(question))
  end
end
