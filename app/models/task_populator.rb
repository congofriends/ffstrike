class TaskPopulator 

  SPEAKOUT_TASKS = 
    ["Task 1 for Speakout", "Task 2 for speakout"]
  RALLY_TASKS = 
    ["Task 1 for Rally", "Task 2 for rally"]
  
  EVENT_TYPES = [["Speak Out", "Speak Out"],["Rally", "Rally"]]

  def self.assign_tasks(event)
    if event.event_type == "Speak Out"
      SPEAKOUT_TASKS.each do |desc|
        event.tasks << Task.create(description: desc)
      end
    end
    if event.event_type == "Rally"
      RALLY_TASKS.each do |desc|
        event.tasks << Task.create(description: desc)
      end
    end
  end

end
