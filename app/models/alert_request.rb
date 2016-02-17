class AlertRequest < ActiveRecord::Base
  before_save :cache_offset_date

  belongs_to :event

  validates :offset_in_seconds, presence: true, numericality: true
  validates :event, presence: true

  def calculated_offset_date
    (event.date.to_time - (offset_in_seconds)).to_date
  end

  private

  def cache_offset_date
    calculated_date = calculated_offset_date

    if calculated_date != self.offset_date
      self.offset_date = calculated_date
    end
  end
end