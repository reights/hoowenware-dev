# Testing Add Invitation feature

require 'spec_helper'

feature 'Adding an Invitation' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:user3) { FactoryGirl.create(:user) }
  let!(:user4) { FactoryGirl.create(:user) }
  let!(:trip) { FactoryGirl.create(:trip, user: user) }

  before do
    login_as(user, :scope => :user)
    visit edit_trip_url(trip)
  end

  after do
    logout(:user)
    Warden.test_reset!

  end

  scenario 'adding invitee' do
    within '.trip-invitations' do
      click_link_or_button 'Email'
    end

    within '.email-addresses' do
      fill_in 'Email Addresses', with: user2.email+','+user3.email+','+
                                      user4.email
    end
    click_link_or_button 'Add'

    expect(page).to have_content(user2.email)
    expect(page).to have_content(user3.email)
    expect(page).to have_content(user4.email)

    visit edit_trip_url(trip)
    expect(page).to have_content(user2.email)
    expect(page).to have_content(user3.email)
    expect(page).to have_content(user4.email)
  end
end
