class Event < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :event_type, presence: true, inclusion: { in: lambda {|obj| Event.event_types} }
  validates :date, presence: true

  def self.event_types
    %w(Anniversary Birthday Holiday)
  end
end
