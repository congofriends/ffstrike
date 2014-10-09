class EventsIndexPage
  include Capybara::DSL

  def navigate_to
    click_link_or_button "events-index"
  end

end
