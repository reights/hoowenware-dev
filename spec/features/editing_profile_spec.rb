# Testing Editing a User Profile

require 'spec_helper'

feature 'Editing Profile' do
  let!(:user) { FactoryGirl.create(:user) }

  before do
    sign_in_as!(user)
    visit "/users/#{user.id}/edit"
  end

  scenario 'editing a users profile' do
    fill_in 'First Name:', with: 'Christopher'
    fill_in 'Last Name:', with: 'Wallace'
    select 'male', from: 'Gender:'
    select 'married', from: 'Status:'
    fill_in 'Zip Code', with: '11222'
    fill_in 'Mobile No:', with: '917 555-5112'
    fill_in 'Skype ID:', with: 'franz_rizzah'
    select 'none', from: 'Dietary Preferences:'
    select 'group females', from: 'Roommate Preferences:'

    click_button 'Update'

    expect(page).to have_content('Your profile has been updated')
  end
end
