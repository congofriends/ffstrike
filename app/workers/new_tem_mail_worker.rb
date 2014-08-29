class NewTeamMailWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false, :backtrace => true

  def perform(user_id, team_id)
    UserMailer.team_creation_message(user_id, team_id)
  end

end
