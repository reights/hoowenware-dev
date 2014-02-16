# invitaion factory for integration testing

FactoryGirl.define do
  factory :invitation do
    trip_id 1
    email { generate(:email) }
    user_id 1
  end
end