# Testing Adding User Posts To Trips

require "spec_helper"

feature "Adding User Posts To Trips" do
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

  scenario 'adding a post' do
    within '.trip-post' do
      fill_in 'Message:', with: 'This is just a test'
      click_link_or_button 'Submit'
    end
    within '.user-post' do
      expect(page).to have_content user2.full_name
      expect(page).to have_content 'This is just a test'
    end
  end
end
