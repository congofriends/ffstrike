# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Ffstrike::Application.load_tasks

namespace :mongo do
  db_dir = File.expand_path('./db/mongo')

  desc 'Start the mongodb server'
  task :start do
    Dir.mkdir(db_dir) unless Dir.exists?(db_dir)
    sh "mongod --dbpath='#{db_dir}' --logpath='#{db_dir}.log' -vvvv --fork"
  end

  desc 'Stop the mongodb server'
  task :stop do
    lockfile = "#{db_dir}/mongod.lock"
    sh "ps -p $(cat #{lockfile}) && kill -9 $(cat #{lockfile})" do |ok, result|; end if File.exists? lockfile
  end

  desc 'Destroy the mongodb server and all its contents'
  task :destroy => [:stop] do
    sh "rm -rf #{db_dir}*"
  end
end
