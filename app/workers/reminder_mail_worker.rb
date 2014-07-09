class ReminderMailWorker
	include Sidekiq::Worker

 	def perform(user_id, event_id)
  	UserMailer.reminder_message(user_id, event_id)
  end

end
