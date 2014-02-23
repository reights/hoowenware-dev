# Testing RSVPing to a trip

require "spec_helper"

feature "RSVPing to a trip" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:trip) { FactoryGirl.create(:trip, user: user)}
  
  before do
    login_as(user2, :scope => :user)
    visit trip_path(trip)
  end

  after do
    logout(:user)
    Warden.test_reset!
  end

  scenario 'rsvping yes' do

    within '.rsvp' do
      click_link_or_button 'Yes'
    end

    expect(page).to have_content('Your rsvp has been updated.')
  end

    scenario 'rsvping no' do

    within '.rsvp' do
      click_link_or_button 'No'
    end

    expect(page).to have_content('Your rsvp has been updated.')
  end

    scenario 'rsvping maybe' do

    within '.rsvp' do
      click_link_or_button 'Maybe'
    end

    expect(page).to have_content('Your rsvp has been updated.')
  end
end
