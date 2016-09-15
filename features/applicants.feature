Feature: Applicants apply for funds
  Scenario: A team member creates a new applicant and assigns it to themselves
    When I log in as a team member
    Then I should see "Hi Team member!"
    And I should see "You are helping nobody"

    When I create a new applicant
    Then I should see "Applicant created"

    # And I create a new name change application for the applicant
    # Then I should see "Application for name change created"

    # When I assign the applicant to myself
    # And I log in as a team member
    # Then I should see "Hi Team member!"
    # And I should see "You are helping 1 person"
