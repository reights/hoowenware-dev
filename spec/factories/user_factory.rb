# user factory for integration testing

FactoryGirl.define do
	sequence(:email) {|n| "user#{n}@example.com"}

	factory :user do
    first_name 'Developer'
    last_name 'Account'
		email { generate(:email) }
		password 'passw0rd'
		password_confirmation 'passw0rd'

		factory :admin_user do
			admin true
		end
	end
end