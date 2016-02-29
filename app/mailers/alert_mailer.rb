class AlertMailer < ApplicationMailer
  default from: "no-reply@wfsbs.com"

  def upcoming_birthday(alert_request_id)
    @alert_request = AlertRequest.find(alert_request_id)
    @event = @alert_request.event
    @days = @alert_request.days_away

    mail(to: @alert_request.user.email, subject: "BLASTED: #{@alert_request.event.title}")
  end

  def upcoming_anniversary(alert_request_id)
    @alert_request = AlertRequest.find(alert_request_id)
    @event = @alert_request.event
    @days = @alert_request.days_away

    mail(to: @alert_request.user.email, subject: "BLASTED: #{@alert_request.event.title}")
  end

  def upcoming_holiday(alert_request_id)
    @alert_request = AlertRequest.find(alert_request_id)
    @event = @alert_request.event
    @days = @alert_request.days_away

    mail(to: @alert_request.user.email, subject: "BLASTED: #{@alert_request.event.title}")
  end
end
