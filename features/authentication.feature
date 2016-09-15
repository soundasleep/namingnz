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

  Scenario: A new user does not see the list of users, or applicants
    Given there is another anonymous user
    When I login with the other Google account
    Then I should see "Your account still needs to be verified by another team member"

    When I visit the list of users
    Then I should see an error

    When I visit the list of team members
    Then I should see an error

    When I visit the list of applicants
    Then I should see an error
