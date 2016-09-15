Feature: Authentication with Google OAuth2
  Scenario: An anonymous person visits the home page
    When I visit the home page
    Then I should see "Sign in"
    And I should not see "Sign out"

  Scenario: A valid user can log in and log out
    When I visit the home page
    And I login with my Google account
    Then I should see "Sign out"
    And I should not see "Sign in"

    When I click "Sign out"
    Then I should see "Sign in"
    And I should not see "Sign out"
