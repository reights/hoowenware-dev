# Testing deleting trips feature

require 'spec_helper'

feature 'Deleting Trips feature' do
	user = FactoryGirl.create(:user, is_admin: true)
	let!(:trip) { FactoryGirl.create(:trip, user: user) }


	scenario 'deleting an trip' do
		# for some reason this needs more than default factory
		sign_in_as!(FactoryGirl.create(:admin_user, email: 'admin@dev.hoowenware.com'))

		visit '/'
		click_link trip.title
		click_link 'Delete This trip'

		expect(page).to have_content("This trip has been deleted.")

		visit '/'

		expect(page).to have_no_content(trip.title)
	end

	scenario 'non-admins cannot delete an trip' do
		# for some reason this needs more than default factory
		sign_in_as!(FactoryGirl.create(:user))

		visit '/'
		click_link trip.title
		expect(page).to_not have_content('Delete This trip')
	end
end
