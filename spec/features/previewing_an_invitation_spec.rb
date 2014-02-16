# Testing Previewing an Invitation

require "spec_helper"

feature "Previewing an Invitation" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:trip) { FactoryGirl.create(:trip, user: user) }
  let!(:date_poll) { FactoryGirl.create(:date_poll, trip_id: trip.id) }
  let!(:location_poll) { FactoryGirl.create(:location_poll, trip_id: trip.id) }

  before do
    login_as(user, :scope => :user)
  end

  after do
    logout(:user)
    Warden.test_reset!
  end

  scenario 'previewing an invite' do
    visit edit_trip_path(trip)
    within '.trip-invitations' do
      click_link_or_button 'Email'
    end

    click_link_or_button 'Preview'
    expect(page).to have_content(user.full_name)
    expect(page).to have_content(trip.title)
    expect(page).to have_content(trip.location)
    expect(page).to have_content(trip.start_date.to_date.strftime("%m/%d/%y"))
    expect(page).to have_content(trip.end_date.to_date.strftime("%m/%d/%y"))

    expect(page).to have_content(date_poll.start_date.to_date.strftime("%m/%d/%y"))
    expect(page).to have_content(date_poll.end_date.to_date.strftime("%m/%d/%y"))
    expect(page).to have_content(location_poll.location)
    expect(page).to have_content('View Trip')
  end
end
