DB_DIR = File.expand_path('./db/mongo')
LOCKFILE = "#{DB_DIR}/mongod.lock"

namespace :mongo do
  def running?
    return false unless File.exists?(LOCKFILE)
    Kernel.system("ps -p $(cat #{LOCKFILE})")
  end

  desc 'Start the mongodb server'
  task :start do
    Dir.mkdir(DB_DIR) unless Dir.exists?(DB_DIR)
    sh "mongod --dbpath='#{DB_DIR}' --logpath='#{DB_DIR}.log' -vvvv --fork" unless running?
  end

  desc 'Stop the mongodb server'
  task :stop do
    sh "kill -9 $(cat #{LOCKFILE})" if running?
  end

  desc 'Destroy the mongodb server and all its contents'
  task :destroy => [:stop] do
    sh "rm -rf #{DB_DIR}*"
  end

  desc 'Seed the mongodb server'
  task :seed => [:environment] do
    Dir["#{File.expand_path('./db/seeds/')}/*.rb"].each do |seed_file|
      require seed_file
    end
  end

  desc 'Create a working, seeded mongo database and run it'
  task :create => [:start, :'db:mongoid:create_indexes', :seed]
end
