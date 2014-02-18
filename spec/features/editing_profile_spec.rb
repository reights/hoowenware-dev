# Testing Editing a User Profile

require 'spec_helper'

feature 'Editing Profile' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:group) { FactoryGirl.create(:group) }

  before do
    login_as(user, :scope => :user)
  end

  after do
    logout(:user)
    Warden.test_reset!
  end

  scenario 'editing a users profile' do
    visit edit_user_path(user)
    fill_in 'First Name:', with: 'Christopher'
    fill_in 'Last Name:', with: 'Wallace'
    select 'male', from: 'Gender:'
    select 'married', from: 'Status:'
    fill_in 'Add Photo:', with: 'http://dummyimage.com/300'
    fill_in 'Zip Code', with: '11222'
    fill_in 'Mobile No:', with: '917 555-5112'
    fill_in 'Skype ID:', with: 'franz_rizzah'
    select 'none', from: 'Dietary Preferences:'
    select 'group females', from: 'Roommate Preferences:'

    within '#edit_user_form' do
      click_button 'Update'
    end

    expect(page).to have_content('Your profile has been updated')
  end

end
