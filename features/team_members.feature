Feature: Team members manage applications
  Scenario: A new user does not see the list of users, or applicants
    Given there is another anonymous user
    When I login with the other Google account
    Then I should not see "Team members"
    And I should not see "Users"
    And I should not see "Applicants"

  Scenario: A team member can see the new user and assign them as a team member
    Given there is another anonymous user
    When I login with my Google account
    Then I should see "Team members"
    And I should see "Users"

    When I visit the list of users
    Then I should not see "Admin (google login) is not a team member"
    And I should see "Anonymous (google login) is not a team member"

    When I visit the list of team members
    Then I should see "Admin team member"
    And I should not see "Anonymous team member"

    When I promote the anonymous user to a team member
    Then I should not see "Admin (google login) is not a team member"
    And I should not see "Anonymous (google login) is not a team member"

    When I visit the list of team members
    Then I should see "Admin team member"
    And I should see "Anonymous team member"

  Scenario: A new user can see the list of users and applicants once promoted to a team member
    Given there is another anonymous user
    When I login with my Google account
    And I promote the anonymous user to a team member

    When I login with the other Google account
    Then I should see "Team members"
    And I should see "Users"
    And I should see "Applicants"

  Scenario: A team member can edit their profile
    When I log in as a team member
    Then I should see "Hi Admin team member!"

    When I click "Edit your profile"
    And I set "team_member[name]" to "My new name"
    And I click the "Update Team member" button
    Then I should see "profile updated"

    When I log in as a team member
    Then I should see "Hi My new name!"

