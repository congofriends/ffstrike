class AddFastFoodStrikeCampaign < ActiveRecord::Migration
  def change
    tag_line = "Fast Food Workers could use your help"
    call_to_action = <<-EOS
     There are 3.5 million fast food workers in America. Thousands of workers have begun to organize a union. You can help them get the word out to their colleagues in every community and every company.

     You first mission as a fast food worker ally: deliver an invitation from the Fast Food Worker Organizing Committee to workers in every fast food restaurant in the country. This site will plug you into a team in your area -- or you can use it to invite your friends to form a new team with you. 
    EOS

    Campaign.create(:name => 'Fast Food Strike', :code => 'ffstrike', :call_to_action => call_to_action, :tag_line => tag_line)
  end
end
