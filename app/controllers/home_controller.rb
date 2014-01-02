class HomeController < ApplicationController
  def index
    @featured_movements = Movement.random(3)
  end
end
