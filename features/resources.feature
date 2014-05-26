Feature:
  In order to see required resources
  As a user
  I want to search resources

  Background:
    Given I am signed in

  @search_book
  Scenario: search books
    Given I have a book resource
    When I visit ebooks index page
    And I enter available as keyword
    And I click search button
    Then I should see key word in the matched text
#    And keyword should be highlighted in yellow
