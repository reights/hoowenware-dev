# user factory for integration testing

FactoryGirl.define do
	sequence(:email) {|n| "user#{n}@example.com"}
	sequence(:first_name) {|n| "Dev #{n}"}

	factory :user do
    first_name { generate(:first_name) }
    last_name 'Account'
		email { generate(:email) }
		password 'passw0rd'
		password_confirmation 'passw0rd'

		factory :admin_user do
			is_admin true
		end
	end
end