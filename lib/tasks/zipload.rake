task :load_zip_codes => :environment do
  puts "destroying old zip codes"
  unless Zipcode.all.length == 0 
    Zipcode.destroy_all  
  end
  file = "lib/assets/US.txt"
  puts "loading zip codes from #{file}"
  File.foreach(file) do |line|
    data = line.split("\t")
    Zipcode.create(zip: data[1], city: data[2], state: data[3], state_abbreviation: data[4], latitude: data[10].to_f, longitude: data[9].to_f)
  end
end

task :load_zip_codes_starting_with_6 => :environment do
  puts "destroying old zip codes"
  unless Zipcode.all.length == 0 
    Zipcode.destroy_all  
  end
  file = "lib/assets/US.txt"
  puts "loading zip codes from #{file}"
  File.foreach(file) do |line|
    data = line.split("\t")
    if data[1][0] == "6" || data[1] == "99553"
      Zipcode.create(zip: data[1], city: data[2], state: data[3], state_abbreviation: data[4], latitude: data[10].to_f, longitude: data[9].to_f)
    end
  end
end

