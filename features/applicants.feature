Feature: Applicants apply for funds
  Scenario: A team member creates a new applicant and assigns it to themselves
    When I log in as a team member
    Then I should see "Hi Admin team member!"
    And I should see "You are helping nobody"

    When I create a new applicant
    Then I should see "Applicant created"

    And I create a new name change application for the applicant
    Then I should see "Application for name change created"

    When I click "Modify assignment"
    And I assign the applicant to myself
    And I click the "Update Applicant" button
    Then I should see "Assigned to Admin team member"

    And I log in as a team member
    Then I should see "Hi Admin team member!"
    And I should see "You are helping 1 person"

  Scenario: A team member creates a new applicant using the form helpers
    When I log in as a team member
    And I visit the list of applicants
    And I click "New applicant"
    Then I should see "Copy and paste"

    When I set "applicant[nickname]" to "Nickname"
    And I set "applicant[form_details]" to "Custom form details"
    And I set "categories[name change]" to "1"
    And I set "notes" to "Custom notes field"
    And I click the "Create Applicant" button
    Then I should see "Applicant created"

    # I should see the custom form details
    And I should see "Nickname"
    And I should see "Custom form details"
    And I should see "Custom notes field"
    And I should see "name change"

    # I can view the name change
    When I click "name change"
    Then I should see "name change"
    And I should see "Assigned to nobody"

  # TODO scenarios for editing applicant nicknames
