# lib/tasks/kill_postgres_connections.rake
namespace :db do
task :kill_test => :environment do
  db_name = "rally_test"
  sh = <<EOF
ps xa \
  | grep postgres: \
  | grep #{db_name} \
  | grep -v grep \
  | awk '{print $1}' \
  | xargs kill
EOF
  puts `#{sh}`
end
end
