class SendEmail
  @queue = :send_emails

  def perform(email_id)
    #TODO: Deliver the email
  end
end