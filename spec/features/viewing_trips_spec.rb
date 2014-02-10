# Testing trip Viewing feature

require 'spec_helper'

feature 'Viewing Trips feature' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:trip) { FactoryGirl.create(:trip, user: user) }

  before do
    sign_in_as!(user)
  end

  scenario 'can view an trips details' do
    visit '/'
    click_link trip.title

    expect(page.current_url).to eql(trip_url(trip))
    expect(page).to have_content(trip.title)
    expect(page).to have_content(trip.start_date.strftime("%m/%d/%y"))
    expect(page).to have_content(trip.end_date.strftime("%m/%d/%y"))
    expect(page).to have_content(trip.location)
  end

  scenario 'shows latest trips on home page' do
    visit '/'
    expect(page).to have_content(trip.title)
  end
end