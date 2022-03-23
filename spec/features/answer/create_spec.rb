require 'rails_helper'

feature 'User can create answer', %q{
  To create a response
  As an authorized user
  I would like to ask an answer 
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answers) { create_list(:answer, 3, question: question, user: user) }

  describe 'Authenticated user' do

    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'create answer', js: true do
      expect(page).to have_content question.title
      expect(page).to have_content question.body
      answers.each do |answer|
        expect(page).to have_content answer.body
      end
      within '.new_answer' do
        fill_in 'Body', with: 'new answer answer answer'
        click_on 'Create answer'
      end
      expect(page).to have_content 'new answer answer answer'
    end

    scenario 'create answer with errors', js: true do
      expect(page).to have_content question.title
      expect(page).to have_content question.body
      answers.each do |answer|
        expect(page).to have_content answer.body
      end
      fill_in 'Body', with: 'new answer'
      click_on 'Create answer'
      expect(page).to have_content 'error'
    end

    scenario 'asks a question with attached file', js: true do
      
      within '.new_answer' do
        fill_in 'Body', with: 'new answer answer answer'
        attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
        click_on 'Create answer'
      end
      save_and_open_page
      within '.answers' do
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
    end
  end

  scenario 'Unauthenticated User not see link to create answer' do
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    answers.each do |answer|
      expect(page).to have_content answer.body
    end
    expect(page).to_not have_link 'Create answer'
  end

  context 'mulitple sessions' do
    given(:some_url) { 'https://ya.ru' }

    scenario "question appears on another user's page" do
      Capybara.using_session('second_user') do
        second_user = create(:user)

        sign_in(second_user)
        visit question_path(question)
      end

      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)

        fill_in 'Title', with: 'answer title'

        attach_files

        fill_in 'Link name', with: 'My link'
        fill_in 'Url', with: some_url

        click_on 'Reply'

        expect(page).to have_content 'answer title'
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end

      Capybara.using_session('second_user') do
        expect(page).to have_content 'answer title'
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
        expect(page).to have_link 'My link', href: some_url
      end
    end
  end
end
