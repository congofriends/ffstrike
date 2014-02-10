class TaskPopulator 

  EVENT_TYPE_FORM = EVENT_DESCRIPTIONS["event_type"].keys.map { |event| event.gsub(/_/, ' ').capitalize }

  def self.assign_tasks(event)
    ATTENDEE_TASKS[event.event_type].each { |task| event.tasks << Task.create(task) } if ATTENDEE_TASKS.has_key? event.event_type
  end

  def self.description(event)
    return EVENT_DESCRIPTIONS[event.event_type] if EVENT_DESCRIPTIONS.has_key? event.event_type
    return
  end

  def self.host_tasks(event)
    return HOST_TASKS[event.event_type] if HOST_TASKS.has_key? event.event_type
    return
  end

end
