class NewMailWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false, :backtrace => true

  def perform(message)
    ContactMailer.new_message(message)
  end
end
