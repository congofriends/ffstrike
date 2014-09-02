class TaskMailWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false, :backtrace => true

  def perform(event_id, task_id, attendee_id)
      UserMailer.task_signup_message(event_id, task_id, attendee_id);
  end
end
