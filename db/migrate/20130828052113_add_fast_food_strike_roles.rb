class AddFastFoodStrikeRoles < ActiveRecord::Migration
  def change
    campaign = Campaign.where(:code => 'ffstrike').first

    roles = [
      {
        :name => 'Mapper',
        :description => "Are you a great back seat driver? Good at using Google Maps. Then Mapper may be the role for you. You'll use a shared Google map to pick out restaurants that no one has contacted yet, then plan a route and print out some maps."
      },
      {
        :name => 'Printer',
        :description => "Your job is simple, but in some ways the most important: printing out and cutting up the leaflets. You'll need a printer and some patience with a pair of scissors. OR you can just go to Kinkos!"
      },
      {
        :name => 'Driver',
        :description => "Any points on your licence? Then don't apply for this role. You've got to transport the team around town. Shy about handing out leaflets in a restaurant? Then you can stay in the car and be the getaway driver."
      },
      {
        :name => 'Coordinator',
        :description => "Your job is to check to make sure the people playing the other three roles got their jobs by a few days before the event. If they didn't, then it's up to you to help them finish, find someone else, or do the job yourself. You are also in charge of picking the meeting place for the event. If you want, you can get the group together for a planning or working meeting before the event."
      }
    ]

    roles.each do |role|
      Role.create(role.merge(:campaign => campaign))
    end
  end
end
