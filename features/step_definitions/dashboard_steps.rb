Then(/^I should see no warnings$/) do
  steps %Q{
    Then I should see 0 warnings
  }
end

Then(/^I should see (\d+) warnings?$/) do |number|
  elements = all(:css, ".warning")
  expect(elements.length).to eq(number.to_i)
end
