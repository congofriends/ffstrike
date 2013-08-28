class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def choose_role
  end
end
