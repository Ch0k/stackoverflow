require 'rails_helper'

feature 'User can sign up', %q{
  Unauthorized user can sign up
} do
  background { visit new_user_registration_path }

  scenario 'Unauthorized user click to sign up' do 
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'Unauthorized user click to sign up with errors' do 
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '654321'
    click_on 'Sign up'
    expect(page).to have_content 'prohibited this user from being saved'
  end

end
