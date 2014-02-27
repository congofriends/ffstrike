class TaskPopulator 

  EVENT_TYPE_FORM = EVENT_DESCRIPTIONS["event_type"].keys.map { |event| event.gsub(/_/, ' ').capitalize }

  def self.assign_tasks(event)
    ATTENDEE_TASKS[event.type].each { |task| event.tasks << Task.create(task) } if ATTENDEE_TASKS.has_key? event.type
  end

  def self.description(event)
    return EVENT_DESCRIPTIONS[event.type] if EVENT_DESCRIPTIONS.has_key? event.type
    return
  end

  def self.host_tasks(event)
    return HOST_TASKS[event.type] if HOST_TASKS.has_key? event.type
    return
  end
end
