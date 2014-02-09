class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter, :linkedin,
                                                :google_oauth2, :yahoo, :windowslive,
                                                :github, :meetup, :dropbox]


  def to_s
    "#{first_name} #{last_name}"
  end

  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider   = auth.provider
      user.uid        = auth.uid
      user.email      = auth.info.email
      user.password   = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name  = auth.info.last_name
      user.avatar     = auth.info.image.split('type=')[0]+'type=large'
      user.oauth_cred = auth.credentials
      user.save!
    end
  end

  def self.find_for_twitter_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider   = auth.provider
      user.uid        = auth.uid
      user.email      = "unknown_twitter_user_#{auth.uid}@hoowenware.com"
      user.password   = Devise.friendly_token[0,20]
      user.first_name = auth.info.name.split(' ')[0]
      user.last_name  = auth.info.name.split(' ')[1]
      user.avatar     = auth.info.image.split('_normal')[0]+auth.info.image.split('_normal')[1]
      user.oauth_cred = auth.credentials
      user.save!
    end
  end

  def self.find_for_linkedin_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider   = auth.provider
      user.uid        = auth.uid
      user.email      = auth.info.email
      user.password   = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name  = auth.info.last_name
      # todo, get larger image http://api.linkedin.com/v1/people/~/picture-urls::(original)
      user.avatar     = auth.info.image
      user.oauth_cred = auth.credentials
      user.save!
    end
  end

  def self.find_for_google_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider   = auth.provider
      user.uid        = auth.uid
      user.email      = auth.info.email
      user.password   = Devise.friendly_token[0,20]
      user.first_name = auth.info.name.split(' ')[0]
      user.last_name  = auth.info.name.split(' ')[1]
      user.avatar     = auth.info.image
      user.oauth_cred = auth.credentials
      user.save!
    end
  end

  def self.find_for_yahoo(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider   = auth.provider
      user.uid        = auth.uid
      user.email      = auth.info.email
      user.password   = Devise.friendly_token[0,20]
      user.first_name = "User_" + user.uid
      user.last_name  = "Yahoo"
      user.avatar     = auth.info.image
      user.oauth_cred = auth.credentials
      user.save!
    end
  end

  def self.find_for_windowslive(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider   = auth.provider
      user.uid        = auth.uid
      user.email      = auth.info.email || "unknown_windowslive_user_#{auth.uid}@hoowenware.com"
      user.password   = Devise.friendly_token[0,20]
      user.first_name = auth.info.name.split(' ')[0]
      user.last_name  = auth.info.name.split(' ')[1]
      user.avatar     = "https://apis.live.net/v5.0/#{auth.id}/picture"
      user.oauth_cred = auth.credentials
      user.save!
    end
  end

  def self.find_for_github_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider   = auth.provider
      user.uid        = auth.uid
      user.email      = auth.info.email
      user.password   = Devise.friendly_token[0,20]
      user.first_name = auth.info.name.split(' ')[0]
      user.last_name  = auth.info.name.split(' ')[1]
      user.avatar     = self.gravatar_url(auth.info.email)
      user.oauth_cred = auth.credentials
      user.save!
    end
  end

  def self.find_for_meetup_oauth(auth)
    auth.uid = auth.uid.to_s
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider   = auth.provider
      user.uid        = auth.uid.to_s
      user.email      = "unknown_meetup_user_#{auth.uid}@hoowenware.com"
      user.password   = Devise.friendly_token[0,20]
      user.first_name = auth.info.name.split(' ')[0]
      user.last_name  = auth.info.name.split(' ')[1]
      user.avatar     = auth.info.image
      user.oauth_cred = auth.credentials
      user.save!
    end
  end

  def self.find_for_dropbox_oauth(auth)
    auth.uid = auth.uid.to_s
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider   = auth.provider
      user.uid        = auth.uid
      user.email      = auth.info.email
      user.password   = Devise.friendly_token[0,20]
      user.first_name = auth.info.name.split(' ')[0]
      user.last_name  = auth.info.name.split(' ')[1]
      user.avatar     = self.gravatar_url(auth.info.email)
      user.oauth_cred = auth.credentials
      user.save!
    end
  end


  private
    # quick method to see what the oauth provider returns
    def self.console_log(oauth_response)
      require 'pp'
      5.times { puts '' }
      pp oauth_response
      5.times { puts '' }
    end

    # gravatar imgage url generator
    def self.gravatar_url(email)
      require 'digest/md5'
      hash = Digest::MD5.hexdigest(email.downcase)
      image_src = "http://www.gravatar.com/avatar/#{hash}?s=300"
      return image_src
    end
end
