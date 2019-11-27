require 'rails_helper'

feature 'login to book review' do
  scenario 'login successfully' do
    #set up
    user = User.create(username: 'faya', email: 'faya@ggg.com', password: '1234')
    # act
    visit('/')
    click_on('log in')
    fill_in('session_email', with: 'faya@ggg.com')
    fill_in('session_password', with: '1234')
    click_on('sign in')
    #verify
    expect(page).to have_content('you have successfully logged in faya')
  end

  scenario 'login fails, wrong password' do
    #set up
    user = User.create(username: 'faya', email: 'faya@ggg.com', password: '1234')
    # act
    visit('/')
    click_on('log in')
    fill_in('session_email', with: 'faya@ggg.com')
    fill_in('session_password', with: '7654')
    click_on('sign in')
    #verify
    expect(page).to have_content('there is a mistake in the credential you entered, try it again')
  end

  scenario 'login fails, wrong email' do
    #set up
    user = User.create(username: 'faya', email: 'faya@ggg.com', password: '1234')
    # act
    visit('/')
    click_on('log in')
    fill_in('session_email', with: 'faya@g.com')
    fill_in('session_password', with: '1234')
    click_on('sign in')
    #verify
    expect(page).to have_content('there is a mistake in the credential you entered, try it again')
  end

end
