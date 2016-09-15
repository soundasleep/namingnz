def new_user
  @new_user ||= User.create! name: "Admin", provider: "google login"
end

def new_team_member
  @new_team_member ||= new_user.team_members.create! name: "Admin team member", email: "team@example.com", phone: "0"
end

def new_anonymous_user
  @new_anonymous_user ||= User.create! name: "Anonymous", provider: "google login"
end

When(/^I login with my Google account$/) do
  steps %Q{
    Given there is a team member already set up
  }

  # We don't actually test the whole OAuth2 workflow, we just expect it to work
  visit("/sessions/login_as?user_id=#{new_user.id}")
end

When(/^I log in as a team member$/) do
  steps %Q{
    Given there is a team member already set up
    Then I login with my Google account
    Then I should see "Hi"
  }
end

Given(/^there is a team member already set up$/) do
  new_team_member
end

Given(/^there is another anonymous user$/) do
  steps %Q{
    Given there is a team member already set up
  }
  new_anonymous_user
end

When(/^I login with the other Google account$/) do
  # We don't actually test the whole OAuth2 workflow, we just expect it to work
  visit("/sessions/login_as?user_id=#{new_anonymous_user.id}")
end

When(/^I promote the anonymous user to a team member$/) do
  steps %Q{
    Then I visit the list of users
    Then I click "Promote to team member"
    Then I set "Name" to "Anonymous team member"
    Then I set "Email" to "anonymous@example.com"
    Then I set "Phone" to "0"
    Then I click the "Create Team member" button
  }
end

Then(/^I should see an error$/) do
  steps %Q{
     Then I should see "Your account still needs to be verified by another team member"
  }
end
