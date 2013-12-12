class MovementsController < ApplicationController
  def new
    @movement = Movement.create
  end
end
