class SurveyMailWorker
  include Sidekiq::Worker
	sidekiq_options :retry => false, :backtrace => true

  def perform(user_id, event_id)
    UserMailer.survey_message(user_id, event_id)
  end
end
