# Testing Editing Transportation feature

require "spec_helper"

feature "Editing Transportation feature" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:trip) { FactoryGirl.create(:trip, user: user) }
  let!(:rsvp) { FactoryGirl.create(:rsvp, user: user, response: 'yes') }
  let!(:transportation) { FactoryGirl.create(:transportation, trip: trip, user: user) }

  before do
    login_as(user, :scope => :user)
    visit trip_path(trip.id)
  end

  after do
    logout(:user)
    Warden.test_reset!
  end

  scenario 'editing a transportation record' do
    
    within '.going' do
      click_link_or_button 'Update Travel Itenerary'
    end

    fill_in 'Service Number:', with: '54'
    fill_in 'Seat Number:', with: '5C'
    fill_in 'Price:', with: '345'
    fill_in 'Notes:', with: 'Updated details.'
    fill_in 'Departure Time:', with: '03/02/14 3:00PM'
    fill_in 'Arrival Time:', with: '03/02/14 7:30PM'

    click_link_or_button 'Update'

    expect(page).to have_content('Your travel arrangements have been updated.')
  end
end
