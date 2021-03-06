require 'rails_helper'

feature 'User can sign out', %q{
  Authorized user can log out
} do

  given(:user) { create(:user) }
  scenario 'User click to sign out' do 
    sign_in(user)
    visit questions_path
    click_on 'Sign out'
    expect(page).to have_content 'Signed out successfully.'
  end

end
