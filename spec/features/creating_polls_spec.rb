# Testing Creating Date Polls feature

require 'spec_helper'

feature 'Creating a Date Poll for a Trip' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:trip) { FactoryGirl.create(:trip, user: user)}
  
  before do
    login_as(user, :scope => :user)
  end

  after do
    logout(:user)
    Warden.test_reset!
  end

  scenario 'creating a date poll' do
    visit trip_url(trip)
    click_link 'Settings'

    within '.new-trip-dates' do
      click_link 'polls'
    end
    fill_in 'Title:', with: 'May Travel Poll'
    fill_in 'Start:', with: '05/15/14'
    fill_in 'End:', with: '05/16/14'
    fill_in 'Notes:', with: 'Mid May?'
    fill_in 'Expires:', with: '04/01/14'

    click_link_or_button 'Save'

    expect(page).to have_content('May Travel Poll')

    expect(page).to have_content('04/01/14')
  end

  scenario 'creating a location poll' do
    visit trip_url(trip)
    click_link 'Settings'

    within '.new-trip-location' do
      click_link 'polls'
    end
      fill_in 'Title:', with: 'Alternate Location Poll'
      fill_in 'Location',  with:'Somewhere, anywhere else'
      fill_in 'Notes:', with: 'Where else can we go?'
      fill_in 'Expires:', with: '04/01/14'
    end

end
