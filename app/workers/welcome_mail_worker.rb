class WelcomeMailWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false, :backtrace => true

  def perform(user_id, password, event_id)
  	UserMailer.welcome_message(user_id, password, event_id)
  end

end
