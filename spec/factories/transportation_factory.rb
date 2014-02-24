# transportation factory for integration testing
FactoryGirl.define do
  factory :transportation do
    transportation_type 'airline'
    service_number '999'
    seat_number '1A'
    price 299.99
    deposit_required true
    notes'An Example transportation with example notes'
    departure_city 'NYC'
    departure_date '03/02/14'
    departure_time '03/02/14 12:00PM'
    arrival_city 'Anywhere, USA'
    arrival_date '03/02/14'
    arrival_time '03/02/14 3:30PM'
  end
end