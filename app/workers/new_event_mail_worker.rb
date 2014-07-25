class NewEventMailWorker
	include Sidekiq::Worker

  def perform(user_id, event_id)
    UserMailer.event_creation_message(user_id, event_id)
  end

end
