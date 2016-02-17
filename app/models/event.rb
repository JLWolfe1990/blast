class Event < ActiveRecord::Base
  after_update :touch_alert_requests

  belongs_to :user

  has_many :alerts, through: :alert_requests
  has_many :alert_requests, autosave: true, dependent: :destroy

  accepts_nested_attributes_for :alert_requests

  validates :title, presence: true
  validates :event_type, presence: true, inclusion: { in: lambda {|obj| Event.event_types} }
  validates :date, presence: true

  def self.event_types
    %w(Anniversary Birthday Holiday)
  end

  def alert_requests_attributes=(attr)
    attr.each do |array|
      if elem = alert_requests[array[0].to_i]
        if array[1].values.include?('remove')
          alert_requests[array[0].to_i].destroy!
        else
          alert_requests[array[0].to_i].update_attributes! array[1]
        end
      else
        self.save!
        alert_requests.create! array[1]
      end
    end
  end

  private

  def touch_alert_requests
    alert_requests.map(&:save)
  end
end
