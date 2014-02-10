# Testing Group Viewing

require 'spec_helper'

feature 'Viewing Groups feature' do
  let!(:group) { FactoryGirl.create(:group) }

  before do
  end

  scenario 'viewing groups' do
    visit '/groups'

    expect(page).to have_content(group.name)
  end
end
