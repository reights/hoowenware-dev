# Testing editing an trip feature

require 'spec_helper'

feature 'Editing Trips feature' do
	let!(:user) { FactoryGirl.create(:user) }
	let!(:trip) { FactoryGirl.create(:trip, user: user) }

	before do
		sign_in_as!(user)
		visit '/'
		click_link trip.title
	end
	
	scenario 'editing an trip' do

		click_link 'Settings'

		fill_in 'Trip Title:', with: 'Revised Trip Title'
		
		click_button 'Update'

		expect(page).to have_content('Your trip has been updated')

	end
end
