class DriverApplication < RoleApplication
  TASKS = [
    "Get your valid proof of insurance in your car.",
    "Familiarize yourself with the area your mapper has picked (even if just looking at a map).",
    "Fill your tank"
  ]

  def initialize(args = nil)
    super(args)
    tasks = TASKS.map { |desc| Task.new(:description => desc, :role => self) }
  end
end
