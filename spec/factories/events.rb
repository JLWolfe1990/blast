FactoryGirl.define do
  factory :event do
    event_type "Birthday"
    sequence(:title) {|n| "title#{n}"}
    date Date.today
  end
end