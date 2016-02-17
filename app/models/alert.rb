class Alert < ActiveRecord::Base
  belongs_to :alert_request

  has_one :user, through: :alert_request

  validates :alert_request, presence: true
  validates :body, presence: true, allow_blank: false

  def send!
    raise 'All subclasses must implement their own send! method'
  end
end