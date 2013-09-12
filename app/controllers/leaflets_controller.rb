class LeafletsController < ApplicationController
  def index
    @leaflets = Leaflet.all
  end

  def download
    @leaflet = Leaflet.find(params[:leaflet][:id])
    send_file File.expand_path("./public/downloads/#{@leaflet.file}"), :type => 'application/pdf'
  end
end
