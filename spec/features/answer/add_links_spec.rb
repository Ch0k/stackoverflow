require 'rails_helper'

feature 'User can add links to answer', %q{
  In order to provide additional info to my answer
  As an question's author
  I'd like to be able to add links
} do

  given(:user) {create(:user)}
  given!(:question) { create(:question, user: user) }
  given(:gist_url) {'https://gist.github.com/vkurennov/743f9367caa1039874af5a2244e1b44c'}
  given(:gist_url2) {'https://google.com'}
  given(:gist_url3) {'123'}

  scenario 'User adds non valide  link when give an answer', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Body', with: 'new answer answer answer'

    fill_in 'Link name', with: 'My gist unvalide link'
    fill_in 'Url', with: gist_url3

    click_on 'Create answer'
    within '.answers' do
      expect(page).to_not have_link 'My gist', href: gist_url3
    end
  end

  scenario 'User adds link when give an answer', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Body', with: 'new answer answer answer'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url2

    click_on 'Create answer'
    within '.answers' do
      expect(page).to have_link 'My gist', href: gist_url2
    end
  end

  scenario 'User adds links when give an answer', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Body', with: 'new answer answer answer'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url2

    click_on 'add link'

    within all('.nested-fields').last do

      fill_in 'Link name', with: 'My gist2'
      fill_in 'Url', with: gist_url2
    
    end 

    click_on 'Create answer'

    
    within '.answers' do
      expect(page).to have_link 'My gist', href: gist_url2
      expect(page).to have_link 'My gist2', href: gist_url2
    end
  end

end
