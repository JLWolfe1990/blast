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

  def self.not_sent
    find_by_sql(
      "SELECT ar1.*
       FROM events INNER JOIN ( SELECT alert_requests.*
                                FROM alert_requests
                                WHERE alert_requests.id NOT IN ( SELECT DISTINCT alerts.alert_request_id
                                                                 FROM alerts
                                                                 WHERE alerts.type in ('Email') AND alerts.sent_at > '#{Date.today.beginning_of_year.to_s(:db)}')) as ar1 ON ar1.event_id = events.id
       WHERE events.date >= '#{Date.today.to_s(:db)}'"

    )
  end

  def calculated_offset_date
    (event.date.to_time - (offset_in_seconds)).to_date
  end

  def days_away
    self.offset_in_seconds / ( 60 * 60 * 24 )
  end

  def sent?
    emails.where("alerts.sent_at > '#{Date.today.beginning_of_year.to_s(:db)}'").count > 1 && event.date >= Date.today
  end

  private

  def cache_offset_date
    calculated_date = calculated_offset_date

    if calculated_date != self.offset_date
      self.offset_date = calculated_date
    end
  end
end