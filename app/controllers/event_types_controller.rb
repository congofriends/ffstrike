class EventTypesController < ApplicationController

	def update
		load_event_type
    @event_type.update_attributes(event_type_params)
    redirect_to request.referer
  end

  private

  def event_type_params
    params[:event_type][:id] = EventType.find_by(name: params[:event_type][:id]).id if params[:event_type][:id]
    params.require(:event_type).permit(:image, :name)
  end

  def load_event_type
    @event_type = EventType.find_by(id: params[:id])
  end


end