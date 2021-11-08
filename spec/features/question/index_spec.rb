require 'rails_helper'

feature 'User can see all question', %q{
  the user can look at all the questions to find a similar question   
} do

  given!(:questions) { create_list(:question, 3) }

  scenario 'User see all question' do
    visit questions_path
    questions.each do |question|
      expect(page).to have_content question.title
    end
  end

end

