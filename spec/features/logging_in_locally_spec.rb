# Testing User sign up and sign in

require 'spec_helper'

feature 'Signup feature' do
	let!(:new_user) { FactoryGirl.build(:user) }
	let!(:existing_user) { FactoryGirl.create(:user) }


	scenario 'signing up' do
		visit '/users/sign_up'

		fill_in 'First name', with: new_user.first_name
		fill_in 'Last name', with: new_user.last_name
		fill_in 'Email', with: new_user.email
		fill_in 'Password', with: new_user.password
		fill_in 'Password confirmation', with: new_user.password_confirmation
		click_button 'Sign up'

		expect(page).to have_content 'Welcome! You have signed up successfully.'
		expect(page).to have_content new_user.first_name
	end

	scenario 'signing in' do
		visit '/users/sign_in'

		fill_in 'Email', with: existing_user.email
		fill_in 'Password', with: existing_user.password
		click_button 'Sign in'

		expect(page).to have_content 'Signed in successfully.'
		expect(page).to have_content existing_user.first_name
	end
end
