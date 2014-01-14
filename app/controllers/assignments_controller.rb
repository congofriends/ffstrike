class AssignmentsController < ApplicationController
  before_filter :load_task, :only => [:assign]   

  def assign
    @task.assign!(current_user)
    respond_to do |format|
      format.html { redirect_to  movement_path(@movement, anchor: "tasks"), notice: "Task is assigned" }
      format.js
    end
  end

private
  def load_task
    @task = Task.find(params[:id])
  end
end
