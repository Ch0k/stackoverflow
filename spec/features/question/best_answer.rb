require 'rails_helper'

feature 'User can create best answer', %q{
  the user author of question select best answer for question   
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answers) { create_list(:answer, 3, question: question, user: user) }
  
  scenario 'User see link to create answer for question' do
    sign_in(user)
    visit question_path(question)
    expect(page).to have_link "Select best answer"
  end

  scenario 'User select best answer for quesiton' do
    sign_in(user)
    visit question_path(question)
    click_on 'Select best answer'
    select('Option', :from => 'Select Box')
    click_on 'Best answer create success'
  end
end

