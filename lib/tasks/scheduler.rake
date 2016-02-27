namespace :scheduler do
  desc "Trigger alerts to start processing"
  task :trigger_alerts => :environment do
    puts "Trigger the processing of all Alerts"
    Resque.enqueue(ProcessAlerts)
  end
end
