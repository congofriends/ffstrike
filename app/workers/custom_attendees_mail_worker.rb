class CustomAttendeesMailWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false, :backtrace => true
  
  def perform(message, subject, action)
    UserMailer.custom_attendees_message(message, subject, action)
  end
end
