class Email < Alert
  validates :subject, presence: true
  validates :body, presence: true

  def send!
    Resque.enqueue(SendEmail, id)
  end

  def resend!
    Resque.enqueue(SendEmail, id)
  end
end