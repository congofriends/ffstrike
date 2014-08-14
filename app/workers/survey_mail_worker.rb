class SurveyMailWorker
  include Sidekiq::Worker

  def perform(user_id, event_id)
    UserMailer.survey_message(user_id, event_id)
  end
end