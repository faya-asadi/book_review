Feature: list_of_books

  in order to see books information in books page
  as a non logged-in user
  I want to see display links

  Scenario: guest user sees display links for books
    Given I am a non_logged_in user
    And there are books
    When I go to book's Page
    Then I must see display links
