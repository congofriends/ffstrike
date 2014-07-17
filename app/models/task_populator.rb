class TaskPopulator

  def self.assign_tasks(event)
    event_type = event.type.downcase.gsub(/ /, '_')
    ATTENDEE_TASKS[event_type].each { |task| event.tasks << Task.create(description: task) } if ATTENDEE_TASKS.has_key? event_type
  end

  def self.description(event)
    return EVENT_DESCRIPTIONS[event.type] if EVENT_DESCRIPTIONS.has_key? event.type
    return
  end

  def self.host_tasks(event)
    event_type = event.type.downcase.gsub(/ /, '_')
    return HOST_TASKS[event_type] if HOST_TASKS.has_key? event_type
    return
  end

  def self.assign_host_tasks(event)
    event_type = event.type.downcase.gsub(/ /, '_')
    HOST_TASKS[event_type].each{ |task| event.tasks << Task.create(description: task, host_task: true)} if HOST_TASKS.has_key? event_type
  end

  def self.assign_all_host_tasks
    Event.all.each do |event|
      event_type = event.type.downcase.gsub(/ /, '_')
      HOST_TASKS[event_type].each{ |task| event.tasks << Task.create(description: task, host_task: true)} if HOST_TASKS.has_key? event_type
    end
  end

end
