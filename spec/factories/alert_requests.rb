FactoryGirl.define do
  factory :alert_request do
    event
    offset_in_seconds 1.day.seconds
  end
end
