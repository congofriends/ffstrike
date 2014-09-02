class NewMovementMailWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false, :backtrace => true

  def perform(message)
    ContactMailer.new_mvmt_message(message)
  end
end
