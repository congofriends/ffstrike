class TasksController < ApplicationController
  def update
    team = Team.find(params[:team_id])
    role = team.role(params[:role_name].to_sym)
    task = role.tasks.select { |t| t.id.to_s == params[:task_id] }.first

    task.done = (params[:done] == "true")
    task.save

    render :nothing => true
  end
end
