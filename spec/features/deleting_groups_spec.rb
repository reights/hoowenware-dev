# Testing deleting grouos feature

require 'spec_helper'

feature 'Deleting Grouos feature' do
  user = FactoryGirl.create(:user, is_admin: true)
  let!(:group) { FactoryGirl.create(:group) }


  scenario 'deleting an group' do
    # for some reason this needs more than default factory
    sign_in_as!(FactoryGirl.create(:admin_user, email: 'admin@dev.hoowenware.com'))

    visit '/groups'
    click_link group.name
    click_link 'Delete This group'

    expect(page).to have_content("This group has been deleted.")

    visit '/groups'

    expect(page).to have_no_content(group.name)
  end

  scenario 'non-admins cannot delete an group' do
    # for some reason this needs more than default factory
    sign_in_as!(FactoryGirl.create(:user))

    visit '/groups'
    click_link group.name
    expect(page).to_not have_content('Delete This group')
  end
end
