require 'rails_helper'
require_relative '../support/new_signup_form'

feature 'sign up review' do
  let(:new_signup_form) {NewSignupForm.new}

  scenario 'sign up successfully' do
    new_signup_form.visit_page.fill_it_with.sign_up
    expect(page).to have_content("you're successfully signed up")
  end

  scenario 'sign up fails, invalid data, redundant username' do
    user = User.create(username: 'faya', email: 'faya@ggg.com', password: '1234')
    new_signup_form.visit_page.fill_it_with(username: 'faya').sign_up

    expect(page).to have_content("Username has already been taken")
  end

  scenario 'sign up fails, invalid data, invalid email' do
    new_signup_form.visit_page.fill_it_with(email: 'faya.com').sign_up

    expect(page).to have_content("Email is not an email")
  end

  scenario 'sign up fails, invalid data, redundant email' do
      user = User.create(username: 'faya', email: 'faya@ggg.com', password: '1234')
    new_signup_form.visit_page.fill_it_with(email: 'faya@ggg.com').sign_up

    expect(page).to have_content("this email exist in our database")
  end

  scenario 'sign up fails, invalid data, empty fields' do
    new_signup_form.visit_page.sign_up

    expect(page).to have_content("Username can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end

end
