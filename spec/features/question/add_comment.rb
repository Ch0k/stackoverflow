require 'rails_helper'

feature 'User can add comments to question' do
  given!(:user)     { create(:user) }
  given!(:question) { create(:question, user: user) }

  describe 'Authenticated user', js: true do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'add new comment to question' do
      within '.new-comment' do
        fill_in 'Body', with: 'Test comment'
        click_on 'Add comment'
      end
      expect(page).to have_content 'Comment successfuly created'
    end
  end

  context 'mulitple sessions', js: true do
    scenario "question appears on another user's page" do
      Capybara.using_session('second_user') do
        second_user = create(:user)

        sign_in(second_user)
        visit question_path(question)
      end

      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
        within '.new-comment' do
          fill_in 'Body', with: 'Test comment'
          click_on 'Add comment'
        end
        expect(page).to have_content 'Comment successfuly created'
      end

      Capybara.using_session('second_user') do
        expect(page).to have_content 'Test comment'
      end
    end
  end
end
