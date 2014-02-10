# Testing Editing a Groiup

require 'spec_helper'

feature 'Editing Groups' do
  let!(:group) { FactoryGirl.create(:group) }

  before do
    visit "/groups/#{group.id}/edit"
  end

  scenario 'editing a groups details' do
    fill_in 'Group Name:', with: 'Revised Group Name'
    click_button 'Update'

    expect(page).to have_content('Your group has been updated')
  end
end
