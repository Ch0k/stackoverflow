require 'rails_helper'

feature 'User can add links to question', %q{
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
} do

  given(:user) { create(:user) }

  scenario 'User adds badge when asks question' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Badge name', with: 'My badge'
    attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb"]
    
    click_on 'Ask'

    expect(page).to have_link 'rails_helper.rb'
  end
end
