create_events_page = CreateEventsPage.new

When(/^I email my attendees for the event/)do
  create_events_page.email_attendees_for_an_event()
end