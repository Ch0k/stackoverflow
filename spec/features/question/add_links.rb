require 'rails_helper'

feature 'User can add links to question', %q{
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
} do

  given(:user) { create(:user) }
  given(:gist_url) { 'https://ZZS.ru' }
  given(:gist_url2) { 'https://google.com' }
  given(:gist_url3) {'123'}

  scenario 'User adds link when asks question' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url
    
    click_on 'Ask'

    expect(page).to have_link 'My gist', href: gist_url
  end

  scenario 'User adds non valide  link when give an answer' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Link name', with: 'My gist unvalide link'
    fill_in 'Url', with: gist_url3

    click_on 'Ask question'

    expect(page).to_not have_link 'My gist unvalide link', href: gist_url3
  end

  scenario 'User adds links when asks question' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'add link'
    
    within all('.nested-fields').last do
      fill_in 'Link name', with: 'My gist2'
      fill_in 'Url', with: gist_url2
    end

    click_on 'Ask question'
    expect(page).to have_link 'My gist', href: gist_url
    expect(page).to have_link 'My gist2', href: gist_url2
  end
end
