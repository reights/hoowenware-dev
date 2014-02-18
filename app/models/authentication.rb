class Authentication < ActiveRecord::Base
  devise :omniauthable, :omniauth_providers => [:facebook, :twitter, :linkedin,
                                                :google, :yahoo, :windowslive,
                                                :github, :meetup, :dropbox]
  belongs_to :user

  ####
  # ToDo: This is monkey patched to allow for multiple social account to a single
  # local user account. The problem is, it generates a generic password for the 
  # local acct. So, if a user logs in via social FIRST, then they wont know their
  # local account (via email) login. Probaly needs some sort of email verification
  # auth. @alvaromuir, 02.16.14
  ####

  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |authentication|
      authentication.provider     = auth.provider
      authentication.uid          = auth.uid
      authentication.email        = auth.info.email
      authentication.token        = auth['credentials']['token']
      authentication.token_secret = nil 
      authentication.expires      = auth['credentials']['expires_at']
      authentication.save!
    end
  end

  def self.find_for_google_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |authentication|
      authentication.provider     = auth.provider
      authentication.uid          = auth.uid
      authentication.email        = auth.info.email
      authentication.token        = auth['credentials']['token']
      authentication.token_secret = nil 
      authentication.expires      = auth['credentials']['expires_at']
      authentication.save!
    end
  end


  def self.find_for_dropbox_oauth(auth)
    auth.uid = auth.uid.to_s
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |authentication|
      authentication.provider     = auth.provider
      authentication.uid          = auth.uid
      authentication.email        = auth.info.email
      authentication.token        = auth['credentials']['token']
      authentication.token_secret = auth['credentials']['secret']
      authentication.expires      = nil
      authentication.save!
    end
  end
end