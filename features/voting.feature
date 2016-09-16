Feature: Team members vote for new applicants
  Scenario: A new applicant is voted in by all team members through the Applicant page
    When I log in as a team member
    And I create a new applicant with a name change

    Then I should see "Team member vote"
    And I should see "new"
    And I should not see "in progress"
    And I should not see "complete"

    When I set my vote to "yes" for a name change
    And I click the "Submit votes" button

    Then I should see "in progress"
    And I should not see "complete"
    And I should see "Vote results"

  # TODO voting for No should mark it as declined

  Scenario: Votes can have notes applied to the vote
    When I log in as a team member
    And I create a new applicant with a name change
    And I set my vote to "yes" for a name change
    And I set "notes" to "Custom vote notes"
    And I click the "Submit votes" button

    Then I should see "in progress"
    And I should see "Custom vote notes"

  Scenario: Mass voting also assigns a team member to the applicant
    When I log in as a team member
    And I create a new applicant with a name change
    And I set my vote to "yes" for a name change
    And I assign the applicant to myself when voting
    And I click the "Submit votes" button

    Then I should see "in progress"
    And I should see "Assigned to Admin team member"
