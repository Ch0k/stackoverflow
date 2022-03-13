require 'rails_helper'

feature 'User can vote', %q{
  As an Authenticated user
  I'd like to be able to vote
} do
  given(:user) { create(:user) }
  given(:author) { create(:user) }
  given!(:question) { create(:question, user: author ) }

  scenario 'can not vote for his question' do
      sign_in(author)
      visit question_path(question)
      expect(page).to_not have_link 'vote'
      expect(page).to_not have_link 'unvote'
  end

  describe 'Authenticated user', js: true do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'can vote' do
      within '.vote' do
        click_on 'vote'
      end
      within '.count' do
        expect(page).to have_content '1'
      end
      expect(page).to have_link 'vote'
    end

    scenario 'can unvote' do
      within '.unvote' do
        click_on 'unvote'
      end
      within '.count' do
        expect(page).to have_content '-1'
      end
    end

    scenario 'can Revote' do
      within '.vote' do
        click_on 'vote'
      end
      click_on 'revote'
      expect(page).to have_content '0'
    end
  end
end
