class TaskPopulator 

  SPEAKOUT_TASKS = DEFAULT_EVENTS["speakout"]
  RALLY_TASKS = DEFAULT_EVENTS["rally"]
  
  EVENT_TYPE_FORM = [["Speak Out", "Speak Out"], ["Rally", "Rally"]] 

  def self.assign_tasks(event)
    populate(event, "Speak Out", SPEAKOUT_TASKS)
    populate(event, "Rally", RALLY_TASKS)
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
