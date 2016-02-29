class AlertRequest < ActiveRecord::Base
  before_save :cache_offset_date

  belongs_to :event

  has_one :user, through: :event

  has_many :alerts
  has_many :emails

  validates :offset_in_seconds, presence: true, numericality: true
  validates :event, presence: true

  def self.to_select
    [
      ["remove", 'remove'],
      ["1 day", 1.day.seconds],
      ["2 days", 2.days.seconds],
      ["3 day", 3.days.seconds],
      ["4 day", 4.days.seconds],
      ["5 day", 5.days.seconds],
      ["6 day", 6.days.seconds],
      ["1 week", 1.week.seconds]
    ]
  end

  def calculated_offset_date
    (event.date.to_time - (offset_in_seconds)).to_date
  end

  def days_away
    self.offset_in_seconds / ( 60 * 60 * 24 )
  end

  private

  def cache_offset_date
    calculated_date = calculated_offset_date

    if calculated_date != self.offset_date
      self.offset_date = calculated_date
    end
  end
end