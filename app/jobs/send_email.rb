class SendEmail
  @queue = :send_emails

  def perform(email_id)
    #TODO: Deliver the email
    email = Email.find(email_id)

    AlertMailer.send("upcoming_#{email.event_type.humanize.underscore.downcase}", email).deliver_now
  end
end