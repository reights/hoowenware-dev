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
		fill_in 'Start', with: '03/08/2013'
		fill_in 'End', with: '03/10/2013'
		select 'public', from: 'Privacy'

		click_button 'Update'

		expect(page).to have_content('Your trip has been updated')

	end
end
