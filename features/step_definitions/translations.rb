home_page = HomePage.new

When(/^user visits the home page/) do
  visit root_path({locale: I18n.locale})
end

When(/^user switches to spanish language/) do
  click_link_or_button('español')
end

When(/^user switches to french language/) do
  click_link_or_button('français')
end

When(/^user switches to italian language/) do
  click_link_or_button('italiano')
end

Then(/^default language is English/) do
  expect(I18n.locale).to eql(:en)
  expect(home_page.translate_home_page(:en)).to be true
end

Then(/^home page content shows in Spanish/) do
  expect(I18n.locale).to eql(:es)
  expect(home_page.translate_home_page(:es)).to be true
end

Then(/^home page content shows in French/) do
  expect(I18n.locale).to eql(:fr)
  expect(home_page.translate_home_page(:fr)).to be true
end

Then(/^home page content shows in Italian/) do
  expect(I18n.locale).to eql(:it)
  expect(home_page.translate_home_page(:it)).to be true
end
