class Team
  include Mongoid::Document
  include Geocoder::Model::Mongoid

  embeds_one :coordinator
  embeds_many :role_applications

  accepts_nested_attributes_for :coordinator
  accepts_nested_attributes_for :role_applications

  field :name,             :type => String
  field :active,           :type => Mongoid::Boolean, :default => true

  field :zip,              :type => String
  field :city,             :type => String
  field :map,              :type => String

  # Required for Geocoding
  field :coordinates,      :type => Array
  after_validation :geocode
  geocoded_by :zip do |obj, results|
    if geo = results.first
      obj.city = geo.city
      obj.coordinates = [geo.longitude, geo.latitude]
    end
  end

  delegate :tasks, to: :coordinator

  def approved_application_exists? user_id
    self.role_applications.each do |application|
      if application.user_id == user_id 
        return true if application.approved?
      end
    end
    return false
  end

  def role(role_name)
    return coordinator if role_name == :coordinator
    self.role_applications.where(:approved => true, :role => role_name).first
  end

  def approved_applications
    self.role_applications.where({:approved => true})
  end
  
  def applications_to_review
    self.role_applications.select { |r| !r.approved? }.sort_by { |r| r.rejected? ? 1 : 0 }
  end

  def approved_application_exceeds_limit
    approved_applications.count >= 3
  end

  def noncompleted_tasks(tasks)
    tasks.where(:done => false).count 
  end

  def completed_tasks(role)
    role.tasks.where(:done => true).count
  end

end
