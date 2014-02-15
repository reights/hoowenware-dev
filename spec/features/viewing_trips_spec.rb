# Testing trip Viewing feature

require 'spec_helper'

feature 'Viewing Trips feature' do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:admin) { FactoryGirl.create(:user, is_admin: true) }
  let!(:trip1) { FactoryGirl.create(:trip, user: user1) }
  let!(:trip2) { FactoryGirl.create(:trip, user: user2, is_active: false) }

  before do
  end

  after do
  end

  scenario 'can view an trips details' do
    visit '/'
    click_link trip1.title

    expect(page.current_url).to eql(trip_url(trip1))
    expect(page).to have_content(trip1.title)
    expect(page).to have_content(trip1.start_date.strftime("%m/%d/%y"))
    expect(page).to have_content(trip1.end_date.strftime("%m/%d/%y"))
    expect(page).to have_content(trip1.location)

    visit user_url(user1)

    expect(page).to have_content(trip1.title)
    expect(page).to have_content(trip1.start_date.strftime("%m/%d/%y"))
    expect(page).to have_content(trip1.end_date.strftime("%m/%d/%y"))
    expect(page).to have_content(trip1.location)

    expect(page).to_not have_content(trip2.title)
    expect(page).to_not have_content(trip2.start_date.strftime("%m/%d/%y"))
    expect(page).to_not have_content(trip2.end_date.strftime("%m/%d/%y"))
    expect(page).to_not have_content(trip2.location)

  end

  scenario 'shows latest trips on home page' do

    visit '/'
    expect(page).to have_content(trip1.title)
    expect(page).to_not have_content(trip2.title)
  end

  scenario 'hide inactive trips from home page' do
    visit '/'
    expect(page).to_not have_content(trip2.title)
  end

  scenario 'show inactive trips on profile page' do
    visit '/'

    expect(page).to_not have_content(trip2.title)

    login_as(user2, :scope => :user)
    visit user_url(user2)
    
    expect(page).to have_content(trip2.title)
    expect(page).to have_content(trip2.start_date.strftime("%m/%d/%y"))
    expect(page).to have_content(trip2.end_date.strftime("%m/%d/%y"))
    expect(page).to have_content(trip2.location)

    logout(:user2)
    Warden.test_reset!
  end
end