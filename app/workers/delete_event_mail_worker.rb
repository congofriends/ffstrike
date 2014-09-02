class DeleteMailWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false, :backtrace => true

  def perform(event_id)
    UserMailer.delete_event_message(event_id);
  end
end
