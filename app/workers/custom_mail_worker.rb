class CustomMailWorker
	include Sidekiq::Worker

  def perform(message, attendee_email)
  	UserMailer.custom_message(message, attendee_email)
  end

end
