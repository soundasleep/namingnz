When(/^I login with my Google account$/) do
  # We don't actually test the whole OAuth2 workflow, we just expect it to work
  user = User.create!
  visit("/sessions/login_as?user_id=#{user.id}")
end
