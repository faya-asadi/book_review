class NewSignupForm
  include Capybara::DSL

  def visit_page
    visit('/')
    click_on('sign up')
    self
  end

  def fill_it_with(params = {})
    fill_in('user_username', with: params.fetch(:username, 'faya'))
    fill_in('user_email', with: params.fetch(:email, 'faya@ggg.com'))
    fill_in('user_password', with: params.fetch(:password, '1234'))
    self
  end

  def sign_up
    click_button('sign up')
    self
  end

end
