class WelcomeMailWorker
	include Sidekiq::Worker

  def perform(user_id, password, event_id)
  	UserMailer.welcome_message(user_id, password, event_id)
  end

end
