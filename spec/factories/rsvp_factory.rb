# rsvp factory for integration testing

FactoryGirl.define do
  factory :rsvp do
    trip_id 1
    user_id 1
    response 'yes'
  end
end