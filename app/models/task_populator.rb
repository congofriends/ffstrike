class TaskPopulator 

  EVENT_TYPE_FORM = EVENT_DESCRIPTIONS["event_type"].keys.map { |event| event.gsub(/_/, ' ').capitalize }
  EVENT_TYPES = EVENT_TYPE_FORM.collect.each_with_index {|i, el| [i, el].reverse}

  def self.assign_tasks(event)
    ATTENDEE_TASKS[event.event_type].each { |task| event.tasks << Task.create(task) } if ATTENDEE_TASKS.has_key? event.event_type
  end

  def self.description(event)
    return EVENT_DESCRIPTIONS[event.event_type] if EVENT_DESCRIPTIONS.has_key? event.event_type
    return
  end

  def self.event_type params
    EVENT_TYPES.select {|ar| ar.first.to_s == params}.flatten.last
  end

  def self.host_tasks(event)
    return HOST_TASKS[event.event_type] if HOST_TASKS.has_key? event.event_type
    return
  end

end
