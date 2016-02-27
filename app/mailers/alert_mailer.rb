class AlertMailer < ApplicationMailer
  def upcoming_birthday(email)
    @email = email
  end

  def upcoming_anniversary(email)
    @email = email
  end

  def upcoming_holiday(email)
    @email = email
  end
end
