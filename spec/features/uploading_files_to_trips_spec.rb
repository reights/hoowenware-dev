# Testing Uploading Assets to Trips feature

require "spec_helper"

feature "Uploading Assets to Trips" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:trip) { FactoryGirl.create(:trip, user: user)}

  before do
    login_as(user, :scope => :user)
  end

  after do
    logout(:user)
    Warden.test_reset!
  end

  scenario 'uploading an asset' do
    visit edit_trip_url(trip)
    attach_file "File", "spec/fixtures/test.jpg"
    click_link_or_button 'Update'
    
    expect(page).to have_content('Your trip has been updated.')

    within(".asset") do
      expect(page).to have_content('test.jpg')
    end
  end

end
