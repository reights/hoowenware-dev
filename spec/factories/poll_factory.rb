# poll factory for integration testing

FactoryGirl.define do
  start = ''
  factory :poll do
    poll_title { generate(:poll_title) }
    sequence(:start_date) {|n| start = gen_random_date }
    sequence(:end_date) {|n| gen_random_date(start) }
    # sequence(:location) {|n| "Location ##{n}"}
    expires Time.now + (10*24*60*60)
  end
end