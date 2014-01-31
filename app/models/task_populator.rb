class TaskPopulator 

  SPEAKOUT_TASKS = DEFAULT_EVENTS["speakout"]
  SPEAKOUT_HOST_TASKS = DEFAULT_EVENTS["speakout_host_tasks"]
  SPEAKOUT_DESCRIPTION = DEFAULT_EVENTS["speakout_description"]

  RALLY_TASKS = DEFAULT_EVENTS["rally"]
  RALLY_HOST_TASKS = DEFAULT_EVENTS["rally_host_tasks"]
  RALLY_DESCRIPTION = DEFAULT_EVENTS["rally_description"]
  
  EVENT_TYPE_FORM = [["Speak Out", "Speak Out"], ["Rally", "Rally"]] 
  def self.assign_tasks(event)
    populate(event, "Speak Out", SPEAKOUT_TASKS)
    populate(event, "Rally", RALLY_TASKS)
  end

  def self.description(event)
    return RALLY_DESCRIPTION if event.event_type == "Rally" 
    return SPEAKOUT_DESCRIPTION if event.event_type == "Speak Out"
    return []
  end

  def self.host_tasks(event)
    return SPEAKOUT_HOST_TASKS if event.event_type == "Speak Out"
    return RALLY_HOST_TASKS if event.event_type == "Rally"
    return []
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
