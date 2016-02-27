desc "Process Alerts"
task :process_alerts => :environment do
  puts "Processing all Alerts"
  ProcessAlerts.perform
  puts "Done processing all Alerts"
end