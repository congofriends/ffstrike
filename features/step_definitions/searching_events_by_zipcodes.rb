When(/^I enter a valid zipcode to search$/) do
  fill_in 'zip', with: '60649'
  click_link_or_button 'search_zip'
end

When(/^I search for a movement with an invalid zipcode$/) do
  fill_in 'zip', with: 'asdff'
  click_link_or_button 'search_zip'
end

When(/^I search for a movement with no zipcode$/) do
  fill_in 'zip', with: ''
  click_link_or_button 'search_zip'
end

Then(/^I see movements within the zipcode given$/) do
  page.has_selector? 'movement_name'
end

Then(/^I see an error message to provide a valid zipcode with only digits$/) do
  page.has_selector? 'zip_error'
end

Then(/^I see an error message to provide a valid zipcode$/) do
  page.has_selector? 'zip_error'
end
