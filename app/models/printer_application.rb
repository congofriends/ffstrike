class PrinterApplication < RoleApplication
  TASKS = [
    "Download your leaflets from the leaflet page (click here to get there).",
    "Double check the leaflets before printing -- make sure they are for your city and not some other city.",
    "Print out the leaflets. (At home, or at a printshop.) And double check again to make sure they are for your city. Print about 30 leaflets (not sheets, but final cut leaflets) for every restaurant your team plans to visit. Over estimate if you're not sure how many restaurants you'll visit -- it's better to have some left over than to run out.",
    "Cut the leaflets if they need cutting. (Or make sure the printshop does it, if you're using a printshop.)"
  ]

  def initialize(args = nil)
    super(args)
    tasks = TASKS.map { |desc| Task.new(:description => desc, :role => self) }
  end
end
