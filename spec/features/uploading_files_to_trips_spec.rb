# Testing Uploading Assets to Trips feature

require "spec_helper"

feature "Uploading Assets to Trips" do
  let!(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user, :scope => :user)
  end

  after do
    logout(:user)
    Warden.test_reset!
  end

  scenario 'uploading an asset' do
    visit '/trips/new'

    within '#new_trip_form' do
      fill_in 'Trip Title:', with: 'Example Trip'
      fill_in 'Hashtag:', with: '#ExampleHashTag'
      fill_in 'Start', with: '03/01/2013'
      fill_in 'End', with: '03/03/2013'
      fill_in 'Location', with: 'Anywhere, USA'
      select 'private', from: 'Privacy'
      check 'Hide Guestlist?'
      attach_file "File #1", Rails.root.join("spec/fixtures/test.jpg")
      attach_file "File #2", Rails.root.join("spec/fixtures/test.ics")
      attach_file "File #3", Rails.root.join("spec/fixtures/test.pdf")
    end

    click_link_or_button 'Create'
    
    expect(page).to have_content('Your trip has been created.')

    within(".assets") do
      expect(page).to have_content('test.jpg')
      expect(page).to have_content('test.ics')
      expect(page).to have_content('test.pdf')
    end
  end

end
