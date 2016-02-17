class ProcessAlerts
  @queue = :process_alerts

  def self.perform()
    AlertRequest.where( offset_date: Date.today ).each do |ar|
      ar.alerts.create.send!
    end
  end
end