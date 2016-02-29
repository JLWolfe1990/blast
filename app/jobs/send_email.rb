class SendEmail
  @queue = :send_emails

  def self.perform(ar_id)
    alert_request = AlertRequest.find(ar_id)
    mailer = AlertMailer.send("upcoming_#{alert_request.event.event_type.humanize.underscore.downcase}", ar_id)
    email = alert_request.emails.create!(body: mailer.body, subject: mailer.subject, recipient_emails: mailer.to.to_a)

    begin
      mailer.deliver_now
      email.update_attributes sent_at: DateTime.now
    rescue
      email.update_attributes failed_at: DateTime.now
    end
  end
end