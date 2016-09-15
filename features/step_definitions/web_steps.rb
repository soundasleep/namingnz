When(/^I visit (\/.*)$/) do |path|
  visit(path)
end

When(/^I visit the home page$/) do
  step 'I visit /'
end

When(/^I click "([^"]*)"$/) do |text|
  click_link(text)
end

Then(/^I should see "([^"]*)"$/) do |text|
  expect(page).to have_content(text)
end

Then(/^I should not see "([^"]*)"$/) do |text|
  expect(page).to_not have_content(text)
end
