def new_applicant
  @new_applicant ||= Applicant.create! nickname: "Applicant"
end

Given(/^there is an applicant assigned to me$/) do
  AssignApplicantToTeamMember.new(team_member: new_team_member, applicant: new_applicant).call
end

Given(/^the applicant has applied for a (.+)$/) do |category|
  @last_application = new_applicant.applications.create! category: category
end

Given(/^the applicant was sent a cheque (\d+) days ago$/) do |days|
  @last_application.cheques.create! amount: 100, payee: "A payee", team_member: new_team_member, created_at: days.to_i.days.ago
end

Given(/^cheques expire in (\d+) days$/) do |days|
  expect(NamingNZ.cheques_expire_in_days).to eq(days.to_i)
end

When(/^I create a new applicant$/) do
  steps %Q{
    And I visit the list of applicants
    And I click "New applicant"
    And I set "applicant[nickname]" to "New applicant"
    And I click the "Create Applicant" button
  }
end

When(/^I create a new applicant with a (.+)$/) do |category|
  steps %Q{
    And I visit the list of applicants
    And I click "New applicant"
    And I set "applicant[nickname]" to "New applicant"
    And I set "categories[#{category}]" to "1"
    And I click the "Create Applicant" button
  }
end

Then(/^I create a new name change application for the applicant$/) do
  steps %Q{
    And I click "New application"
    And I set "Category" to "name change"
    And I click the "Create Application" button
  }
end

When(/^I assign the applicant to myself$/) do
  steps %Q{
    Then I set "applicant[team_member_id]" to "#{new_team_member.id}"
  }
end

When(/^I assign the applicant to myself when voting$/) do
  steps %Q{
    Then I set "team_member_id" to "#{new_team_member.id}"
  }
end

When(/^I set my vote to "([^"]*)" for a (.+)$/) do |vote, category|
  application = Application.where(category: category).only.first
  steps %Q{
    Then I set "vote_#{application.id}_#{new_team_member.id}_#{vote}" to "#{vote}"
  }
end
