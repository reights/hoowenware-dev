# Testing Social OAuth authentication

require 'spec_helper'

feature 'Social OAuth Authentication feature' do

  before do
    OmniAuth.config.test_mode = true
    visit '/'
    click_link 'Sign in'
  end


  scenario "Sign in with Facebook" do
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      provider: 'facebook',
      uid: 'fb_123545',
      info: {
        email: 'testaccount@example.com',
        first_name: 'Test',
        first_name: 'Account',
        image: 'http://www.example.com/img/test12345.jpg?type=square'
      }
    })
    
    first_name = OmniAuth.config.mock_auth[:facebook][:info][:first_name]

    click_link 'Sign in with Facebook'

    expect(page).to have_content 'Successfully authenticated from Facebook account.'
    expect(page).to have_content "#{first_name}"
  end

  scenario "Sign in with Twitter" do
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      uid: 't_123545',
      info: {
        nickname: 'testaccount',
        name: 'Test Account',
        image: 'http://www.example.com/img/test12345_normal.jpg'
      }
    })

    first_name = OmniAuth.config.mock_auth[:twitter][:info][:name].split(' ')[0]

    click_link 'Sign in with Twitter'

    expect(page).to have_content 'Successfully authenticated from Twitter account.'
    expect(page).to have_content "#{first_name}"
  end

  scenario "Sign in with LinkedIn" do
    OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new({
      provider: 'linkedin',
      uid: 'l_123545',
      info: {
        email: 'testaccount@example.com',
        first_name: 'Test',
        first_name: 'Account',
        image: 'http://www.example.com/img/test12345.jpg'
      }
    })

    first_name = OmniAuth.config.mock_auth[:linkedin][:info][:first_name]

    click_link 'Sign in with Linkedin'

    expect(page).to have_content 'Successfully authenticated from Linkedin account.'
    expect(page).to have_content "#{first_name}"
  end

  scenario "Sign in with Google" do
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: 'g_123545',
      info: {
        email: 'testaccount@example.com',
        name: 'Test Account',
        image: 'http://www.example.com/img/test12345.jpg'
      }
    })

    first_name = OmniAuth.config.mock_auth[:google_oauth2][:info][:name].split(' ')[0]

    click_link 'Sign in with Google'

    expect(page).to have_content 'Successfully authenticated from Google account.'
    expect(page).to have_content "#{first_name}"
  end

  scenario "Sign in with Yahoo" do
    OmniAuth.config.mock_auth[:yahoo] = OmniAuth::AuthHash.new({
      provider: 'yahoo',
      uid: 'y_123545',
      info: {
        email: 'testaccount@example.com',
        image: 'http://www.example.com/img/test12345.jpg'
      },
      extra: {
        raw_info: {
          public_display_name: 'Test Account'
        }
      }
    })
  
    data = OmniAuth.config.mock_auth[:yahoo][:extra][:raw_info]
    first_name = data[:uid]

    click_link 'Sign in with Yahoo'

    expect(page).to have_content 'Successfully authenticated from Yahoo account.'
    expect(page).to have_content "#{first_name}"
  end

  scenario "Sign in with Windowsive" do
    OmniAuth.config.mock_auth[:windowslive] = OmniAuth::AuthHash.new({
      provider: 'windowslive',
      uid: 'w_123545',
      info: {
        email: 'testaccount@example.com',
        name: 'Test Account'
      },
    })
  
    data = OmniAuth.config.mock_auth[:windowslive]
    first_name = data[:info][:name].split(' ')[0]

    click_link 'Sign in with Windowslive'

    expect(page).to have_content 'Successfully authenticated from WindowsLive account.'
    expect(page).to have_content "#{first_name}"
  end

  scenario "Sign in with Github" do
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      uid: 'g_123545',
      info: {
        email: 'testaccount@example.com',
        name: 'Test Account'
      }
    })

    first_name = OmniAuth.config.mock_auth[:github][:info][:name].split(' ')[0]

    click_link 'Sign in with Github'

    expect(page).to have_content 'Successfully authenticated from Github account.'
    expect(page).to have_content "#{first_name}"
  end

  scenario "Sign in with Meetup" do
    OmniAuth.config.mock_auth[:meetup] = OmniAuth::AuthHash.new({
      provider: 'meetup',
      uid: 'm_123545',
      info: {
        name: 'Test Account',
        image: 'http://www.example.com/img/test12345.jpg'
      }
    })

    first_name = OmniAuth.config.mock_auth[:meetup][:info][:name].split(' ')[0]

    click_link 'Sign in with Meetup'

    expect(page).to have_content 'Successfully authenticated from Meetup account.'
    expect(page).to have_content "#{first_name}"
  end


  scenario "Sign in with Dropbox" do
    OmniAuth.config.mock_auth[:dropbox] = OmniAuth::AuthHash.new({
      provider: 'dropbox',
      uid: 'm_123545',
      info: {
        email: 'testaccount@example.com',
        name: 'Test Account'
      }
    })
    first_name = OmniAuth.config.mock_auth[:dropbox][:info][:name].split(' ')[0]

    click_link 'Sign in with Dropbox'

    expect(page).to have_content 'Successfully authenticated from Dropbox account.'
    expect(page).to have_content "#{first_name}"
  end  

end
