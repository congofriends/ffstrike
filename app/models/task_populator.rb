class TaskPopulator 

  EVENT_TYPE_FORM = [["Speak Out", "Speak Out"], ["Rally", "Rally"]] 

  def self.assign_tasks(event)
    ATTENDEE_TASKS[event.event_type].each { |task| event.tasks << Task.create(task) } if ATTENDEE_TASKS.has_key? event.event_type
  end

  def self.description(event)
    EVENT_DESCRIPTION[event.event_type] if EVENT_DESCRIPTIONS.has_key? event.event_type
    return []
  end

  def self.host_tasks(event)
    HOST_TASKS[event.event_type] if HOST_TASKS.has_key? event.event_type
  end

  private

  def self.populate(event, event_type, event_tasks)
    if event.event_type == event_type
      event_tasks.each do |task_attributes|
        event.tasks << Task.create(task_attributes)
      end
    end
  end

end
