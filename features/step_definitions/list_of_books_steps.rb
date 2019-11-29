
Given("I am a non_logged_in user") do

end

Given("there are books") do
  @user = FactoryBot.create(:user)
  @Books = FactoryBot.create_list(:book, 5)
end

When("I go to book's Page") do
  visit(books_path)
end

Then("I must see display links") do
  expect(page).to have_content('Display')
end

Then("I must not be able to Create new book or Add a review") do
  expect(page).not_to have_content('Create new book')
  expect(page).not_to have_content('Add a review')
end
