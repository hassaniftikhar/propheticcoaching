Feature:
  In order to use application
  As a user
  I want to login

  Background:
    Given I am not signed in

#  @create_group
  Scenario: Login with valid credentials
    Given I am a valid user
    When I visit the root page
    And I click login link
    Then I should see user_email field
    And I should see user_password field
    And I fill login form with valid data
    And I click on login button
    Then I should be logged in to the site

  Scenario: Login with invalid credentials
    Given I am a valid user
    When I visit the root page
    And I click login link
    Then I should see user_email field
    And I should see user_password field
    And I fill login form with invalid data
    And I click on login button
    Then I should be redirected to signin page