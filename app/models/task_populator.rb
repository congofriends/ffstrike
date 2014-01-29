class TaskPopulator 

  SPEAKOUT_TASKS = DEFAULT_EVENTS["speakout"]
  RALLY_TASKS = DEFAULT_EVENTS["rally"]
  
  EVENT_TYPES = [["Speak Out", "Speak Out"],["Rally", "Rally"]]

  def self.assign_tasks(event)
    if event.event_type == "Speak Out"
      SPEAKOUT_TASKS.each do |task_attributes|
        event.tasks << Task.create(task_attributes)
      end
    end
    if event.event_type == "Rally"
      RALLY_TASKS.each do |task_attributes|
        event.tasks << Task.create(task_attributes)
      end
    end
  end

end
