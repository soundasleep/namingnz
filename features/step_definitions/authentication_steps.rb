def new_user
  @new_user ||= User.create!
end

def new_team_member
  @new_team_member ||= new_user.team_members.create! name: "Team member", email: "team@example.com", phone: "0"
end

When(/^I login with my Google account$/) do
  # We don't actually test the whole OAuth2 workflow, we just expect it to work
  visit("/sessions/login_as?user_id=#{new_user.id}")
end

When(/^I log in as a team member$/) do
  new_team_member

  steps %Q{
    Then I login with my Google account
    Then I should see "Hi"
  }
end
