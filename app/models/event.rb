class Event < ActiveRecord::Base
  after_update :touch_alert_requests

  belongs_to :user
  has_many :alert_requests
  accepts_nested_attributes_for :alert_requests

  validates :title, presence: true
  validates :event_type, presence: true, inclusion: { in: lambda {|obj| Event.event_types} }
  validates :date, presence: true

  def self.event_types
    %w(Anniversary Birthday Holiday)
  end

  #TODO: allow delete
  def alert_requests_attributes=(attr)
    attr.each do |array|
      if elem = alert_requests[array[0].to_i]
        alert_requests[array[0].to_i].update_attributes array[1]
      else
        alert_requests.create array[1]
      end
    end
  end

  private

  def touch_alert_requests
    alert_requests.map(&:save)
  end
end
