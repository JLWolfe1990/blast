FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "#{n}@wfsbs.com"}
    password "fakepass"
    password_confirmation "fakepass"
    #confirmed_at Date.today
  end
end
