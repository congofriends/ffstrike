["Atlanta, GA", "Chicago, IL", "Hartford, CT", "New York, NY", "Springfield, MO"].each do |location|
  Leaflet.create(:location => location, :file => 'lowpayisnotokay.pdf') unless Leaflet.where(:location => location).exists?
end
