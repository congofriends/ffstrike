class ContactController < ApplicationController
  before_filter :load_message
  before_filter :load_event, only: [:new_event_msg, :new_attendees_msg]
  before_filter :load_group, only: [:new_coordinator_attendee_msg, :new_coordinator_hosts_msg, :new_coordinator_msg, :new_members_msg]

  def new_event_msg; end

  def create_event_msg
    @event =  Event.find @message.host_id

    if @message.valid?
      ContactMailer.new_message(@message)
      # NewMailWorker.perform_async(@message) if ENV["RAILS_ENV"] == "production"
      redirect_to :back, notice: t('contact.message_sent') and return
    end
    redirect_to :back, alert: t('contact.invalid_message')
  end

  def new_attendees_msg; end

  def new_coordinator_attendee_msg; end

  def new_coordinator_hosts_msg; end

  def new_coordinator_msg; end

  def create_coordinator_msg
    @group = Movement.find @message.host_id
    if @message.valid?
      ContactMailer.new_coordinators_message(@message)
      # NewCoordinatorsMailWorker.perform_async(@message) if ENV["RAILS_ENV"] == "production"
      redirect_to :back, notice: t('contact.message_sent') and return
    end
    redirect_to :back, alert: t('contact.invalid_message')
  end

  def new_members_msg; end

  def create_members_msg
    @group = Movement.find @message.host_id
    if @message.valid?
      ContactMailer.new_members_message(@message)
      # NewMembersMailWorker.perform_async(@message) if ENV["RAILS_ENV"] == "production"
      redirect_to :back, notice: t('contact.message_sent') and return
    end
    redirect_to :back, alert: t('contact.invalid_message')
  end

  def create_attendees_msg
    @event =  Event.find @message.host_id
    if @message.valid?
      ContactMailer.new_attendee_message(@message)
      # NewAttendeeMailWorker.perform_async(@message) if ENV["RAILS_ENV"] == "production"
      redirect_to :back, notice: t('contact.message_sent') and return
    end
    redirect_to :back, alert: t('contact.invalid_message')
  end

  def new_movement_msg
    @movement = Movement.find_by_param(params[:id])
  end

  def create_movement_msg
    @movement = Movement.find @message.host_id
    if @message.valid?
      ContactMailer.new_mvmt_message(@message)
      # NewMovementMailWorker.perform_async(@message) if ENV["RAILS_ENV"] == "production"
      redirect_to :back, notice: t('contact.message_sent') and return
    end
    redirect_to :back, alert: t('contact.invalid_message')
  end

  private

  def load_event
    @event = Event.find_by_param params[:id]
  end

  def load_group
    @group = Movement.find_by_param params[:id]
  end

  def load_message
    @message ||=
      if params[:message]
        Message.new(params[:message])
      else
        Message.new
      end
  end

end
