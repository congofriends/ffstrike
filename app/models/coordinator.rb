class Coordinator
  include Mongoid::Document

  TASKS = [
    "Email your group by copying and pasting their email addresses from your dashboard. In the email: (1) Ask for a short introduction from everyone, and (2) ask the group if they want to get together before the event, or just meet the day of.",
    "[If the group wants to get together before the event:] Work out a time and place to meet with the group.",
    "[If the group wants to get together before the event:] You're responsible for coordinating the meeting -- just make sure everyone finds you, set the agenda, move the meeting along, and end it when it's done. ",
    "Ask (over email or phone or in person) your Mapper if s/he understand the job and will be able to complete it -- and if they'll be able to finish their tasks by three days before the event. ",
    "Ask (over email or phone or in person) your Printer if s/he understand the job and will be able to complete it -- and if they'll be able to finish their tasks by three days before the event. ",
    "Ask (over email or phone or in person) your Driverif s/he understand the job and will be able to complete it -- and if they'll be able to finish their tasks by three days before the event (except filling up the tank, which should be done the day before). ",
    "If anyone isn't done with their tasks three days before the event, then reach them on the phone and work out how they will get done. If you can't reach them, then either do the task yourself or get another team member to do it. "
  ]

  embedded_in :team
  embeds_many :tasks, :as => :role
  belongs_to :user

  accepts_nested_attributes_for :tasks

  field :why,              :type => String
  field :where,            :type => String
  field :about_private,    :type => String
  field :phone,            :type => String

  def initialize(args = nil)
    super(args)
    tasks = TASKS.map { |desc| Task.new(:description => desc, :role => self) }
  end
end
