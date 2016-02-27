require 'resque/scheduler/tasks'
require 'resque/tasks'

namespace :resque do
  task :setup => :environment do
    require 'resque'

    Resque.redis = 'localhost:6379'
  end

  task :setup_schedule => :setup do
    require 'resque-scheduler'

    Resque.schedule = YAML.load_file 'config/resque_schedule.yml'

    #require 'jobs'
  end

  task :scheduler => :setup_schedule
end