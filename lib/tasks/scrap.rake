
desc "restart worker for test"
task "scrap", [:count] do |t, args|
  count = args[:count].to_i || 100
  Rake::Task["server:stop"].invoke
  Rake::Task["sidekiq:stop"].invoke

  puts "Flushing Redis database..."
  system("redis-cli -r 1 flushdb > /dev/null 2>&1")

  system("cd ~/Git/showtracker")

  puts "Recreating Showtracker Database..."
  system("rake db:drop > /dev/null 2>&1")
  system("rake db:create > /dev/null 2>&1")
  system("rake db:migrate > /dev/null 2>&1")

  Rake::Task["sidekiq:start"].invoke
  Rake::Task["server:start"].invoke

  puts "Starting TriggerCollectionWorker with count of #{count}"
  load "#{Rails.root}/app/workers/trigger_collection_worker.rb"
  TriggerCollectionWorker.perform_async(count)
end

namespace :server do
  desc "Stop Rails Server"
  task "stop" do
    puts "Stopping Rails server..."
    system("kill -9 `ps -ef | grep 'rails s' | awk '{print $2}' | head -1`")
  end

  desc "Start Rails Server"
  task "start" do
    puts "Starting Rails server..."
    system("bundle exec rails s > /dev/null 2>&1 &")
  end
end

namespace :sidekiq do
  desc "Stop Sidekiq"
  task "stop" do
    puts "Stopping Sidekiq..."
    system("kill -9 `ps -ef | grep sidekiq | awk '{print $2}' | head -1`")
  end

  desc "Start Sidekiq"
  task "start" do
    puts "Starting Sidekiq..."
    system("bundle exec sidekiq -C config/sidekiq.yml > /dev/null 2>&1 &")
  end
end
