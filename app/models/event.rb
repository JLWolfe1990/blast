class Event < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :event_type, presence: true

  def self.event_types
    %w(Anniversary Birthday Holiday)
  end
end
