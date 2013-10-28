class RecorderApplication < RoleApplication
  TASKS = [
    "Watch the screencast video (by clicking here) about how to use the shared map to choose your restaurants and mark them as done.",
    "Reserve your turf by drawing a line around the area you plan to cover.",
    "Make a route using Google maps and print it out. Or print out whatever maps and directions will allow you to get the job done.",
    "Go leafleting and celebrate!",
    "As shown in the screencast, add the restaurants you covered to the share Google map.",
    "Sign up to help with the next project, or just stay tuned and join us whenever something looks interesting to you."
  ]

  def initialize(args = nil)
    super(args)
    tasks = TASKS.map { |desc| Task.new(:description => desc, :role => self) }
  end
end
