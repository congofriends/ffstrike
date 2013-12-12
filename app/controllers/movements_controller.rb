class MovementsController < ApplicationController
  def new
    @movement = Movement.new
  end
end
