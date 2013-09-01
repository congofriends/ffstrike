class HomeController < ApplicationController
  before_filter :authenticate_user!

  def start
  end
end
