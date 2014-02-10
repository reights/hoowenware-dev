# Testing cancelling trips feature

require 'spec_helper'

feature 'Canceling Trips feature' do
	let!(:user) { FactoryGirl.create(:user) }
	let!(:trip) { FactoryGirl.create(:trip, user: user) }

	before do
		sign_in_as!(user)
	end

	scenario 'cancelling an trip' do
		visit '/'


		click_link trip.title
		click_link 'Cancel this trip'

		expect(page).to have_content("Your trip has been cancelled.")

		visit '/'

		expect(page).to have_no_content(trip.title)
	end
end
