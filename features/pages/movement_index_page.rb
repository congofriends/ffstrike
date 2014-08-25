class MovementIndexPage
  include Capybara::DSL

  def navigate_to
    click_link_or_button "teams"
  end
end
