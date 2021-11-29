require 'rails_helper'

feature 'User can add links to answer', %q{
  In order to provide additional info to my answer
  As an question's author
  I'd like to be able to add links
} do

  given(:user) {create(:user)}
  given!(:question) {create(:question)}
  given(:gist_url) {'https://gist.github.com/vkurennov/743f9367caa1039874af5a2244e1b44c'}

  scenario 'User remove link when give an answer', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Body', with: 'new answer answer answer'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url

    #within '.answers' do
      expect(page).to have_link 'My gist', href: gist_url
    #end
    save_and_open_page
    click_on 'remove link'

    #within '.answers' do
      expect(page).to_not have_link 'My gist', href: gist_url
    #end

    click_on 'Create answer'
  end
end
