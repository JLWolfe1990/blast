class Event < ActiveRecord::Base
  after_update :touch_alert_requests

  belongs_to :user
  has_many :alert_requests

  validates :title, presence: true
  validates :event_type, presence: true, inclusion: { in: lambda {|obj| Event.event_types} }
  validates :date, presence: true

  def self.event_types
    %w(Anniversary Birthday Holiday)
  end

  private

  def touch_alert_requests
    alert_requests.map(&:save)
  end
end
