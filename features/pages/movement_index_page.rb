class MovementIndexPage
  include Capybara::DSL

  def navigate_to
    click_link_or_button "TEAMS"
  end
end
