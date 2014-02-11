# Testing Group Creation

require 'spec_helper'

feature 'Creating A Group feature' do
  before do
    sign_in_as!(FactoryGirl.create(:user))
  end

  scenario 'creating a group' do
    visit '/groups/new'

    fill_in 'Group Name:', with: 'Test Group'
    click_link_or_button 'Create'

    expect(page).to have_content('This group has been created.')
  end
end
