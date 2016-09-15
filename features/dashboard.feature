Feature: Team members can see a useful dashboard
  Scenario: I'm not assigned to anybody
    When I log in as a team member
    Then I should see "Hi Admin team member!"
    And I should see "You are helping nobody"
    And I should see no warnings

  Scenario: I'm assigned to one person underway
    Given there is an applicant assigned to me
    And the applicant has applied for a name change

    When I log in as a team member
    Then I should see "Hi Admin team member!"
    And I should see "You are helping 1 person"
    And I should see no warnings

  Scenario: I'm assigned to a person with an expiring cheque
    Given there is an applicant assigned to me
    And the applicant has applied for a name change
    And the applicant was sent a cheque 80 days ago
    And cheques expire in 90 days

    When I log in as a team member
    Then I should see "Hi Admin team member!"
    And I should see "You are helping 1 person"
    And I should see 1 warning
    And I should see "Applicant hasn't cashed in their cheque for their name change"
    And I should see "Their cheque will expire in 10 days"
