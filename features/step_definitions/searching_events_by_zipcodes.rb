home_page = HomePage.new

When(/^I enter a valid zipcode to search$/) do
  home_page.search_by_valid_zipcode()
end

When(/^I search for a movement with an invalid zipcode$/) do
  home_page.search_by_invalid_zipcode()
end

When(/^I search for a movement with no zipcode$/) do
	home_page.search_with_no_zipcode()
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
