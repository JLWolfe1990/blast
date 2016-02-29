class Email < Alert
  validates :subject, presence: true
  validates :body, presence: true
  validates :recipient_emails, presence: true, allow_blank: false

  serialize :recipient_emails, Array

  def self.send!(ar_id)
    Resque.enqueue(SendEmail, ar_id)
  end
end