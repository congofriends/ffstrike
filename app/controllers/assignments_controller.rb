class AssignmentsController < ApplicationController
  def assign
    Task.find(params[:id]).assign!(current_user)
    respond_to do |format|
      format.js
    end
  end
end
