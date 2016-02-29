class ProcessAlerts
  @queue = :process_alerts

  def self.perform()
    puts "Queuing #{Date.today.to_s(:db)}'s alerts'"
    AlertRequest.where( offset_date: Date.today ).each do |ar|
      Email.send! ar.id
    end
  end
end