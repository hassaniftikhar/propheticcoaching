Feature:
  In order to see required resources
  As a user
  I want to search resources

  Background:
    Given I am signed in

  @search_book
  @javascript
  Scenario: search books
    Given I have a book resource
    When I visit ebooks index page
    And I enter available as keyword for ebook
    And I click ebook search button
    Then I should see key word in the matched text
    And keyword should be highlighted in yellow

  @search_question
  @javascript
  Scenario: search questions
    Given I have a question resource
    When I visit questions index page
    And I enter question as keyword for question
    And I click question search button
    Then I should see key word in the matched text
#    And keyword should be highlighted in yellow

#  @search_book
#  @javascript
#  Scenario: search books
#    Given I have a book resource
#    When I visit ebooks index page
#    And I enter available as keyword
#    And I click search button
#    Then I should see key word in the matched text
#    And keyword should be highlighted in yellow
#
#  @search_book
#  @javascript
#  Scenario: search books
#    Given I have a book resource
#    When I visit ebooks index page
#    And I enter available as keyword
#    And I click search button
#    Then I should see key word in the matched text
#    And keyword should be highlighted in yellow
