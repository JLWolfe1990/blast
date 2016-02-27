require 'resque/tasks'

namespace :resque do
  task :setup => :environment do
    require 'resque'

    #Resque.redis = 'localhost:6379'
  end
end