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

    click_link_or_button 'Create'

    expect(page).to have_content('May Travel Poll')

  end
end
