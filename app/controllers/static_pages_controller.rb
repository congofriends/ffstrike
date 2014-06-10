class StaticPagesController < ApplicationController

  def index
    @featured_movements = Movement.random(3)
    render layout: 'application'
  end

  def about; end

end
