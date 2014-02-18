# Testing Adding Links to User Profiles

require "spec_helper"


feature "Adding Social Links to User Profiles" do
  let!(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user, :scope => :user)
    visit user_path(user)
  end

  after do
    logout(:user)
    Warden.test_reset!
  end

  scenario 'adding a link' do
    click_link_or_button 'Add a link'
    fill_in 'Link:', with: 'http://www.somenetwork.com/someuser'
    click_link_or_button 'Add'

    expect(page).to have_content('http://www.somenetwork.com/someuser')
  end
end
