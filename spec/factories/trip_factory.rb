# event factory for integration testing

FactoryGirl.define do
	factory :trip do
		title 	'An Example Trip'
		start_date '03/03/14'
		end_date '03/06/14'
		location 'Anywhere, USA'
	end
end