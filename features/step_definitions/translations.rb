home_page = HomePage.new

When(/^user visits the home page/) do
  visit root_path({locale: I18n.locale})
end

When(/^user switches to spanish language/) do
  click_link_or_button('ES')
end

When(/^user switches to french language/) do
  click_link_or_button('FR')
end

Then(/^default language is English/) do
  expect(I18n.locale).to eql(:en)
  home_page.content_is_in_english
end

Then(/^home page content shows in Spanish/) do
  expect(I18n.locale).to eql(:es)
  home_page.content_is_in_spanish
end

Then(/^home page content shows in French/) do
  expect(I18n.locale).to eql(:fr)
  home_page.content_is_in_french
end
