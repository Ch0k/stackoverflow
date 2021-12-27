require 'rails_helper'

feature 'User can see all badges', %q{
  User see all badges
} do

  given!(:user) { create(:user) }
  given!(:question_one) { create(:question, user: user) }
  given!(:question_two) { create(:question, user: user) }
  given!(:badge_one) { create(:badge, question: question_one, user: user) }
  given!(:badge_two) { create(:badge, question: question_two, user: user) }


  scenario 'User see all badges' do
    sign_in(user)
    visit badges_path

    expect(page).to have_content badge_one.name
    expect(page).to have_content badge_two.name
  end
end
