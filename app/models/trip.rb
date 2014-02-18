class Trip < ActiveRecord::Base
  validates :title,       :presence => true, length: { minimum:10 }
  validates :start_date,  :presence => true
  validates :end_date,    :presence => true
  validates :location,    :presence => true

  belongs_to :user
  has_many :permissions, as: :thing
  has_many :polls
  has_many :invitations

  mount_uploader :asset, AssetUploader
  
  scope :viewable_by, ->(user) do
    joins(:permissions).where(permissions: { action: "view", user_id: user.id })
  end

  def has_dates_polls?
    @date_polls =  self.polls.where(:poll_type => 'date')
    if @date_polls.present?
      return true
    end
    return false
  end

  def dates_polls
    return self.polls.where(:poll_type => 'date')
  end

  def has_location_polls?
    @location_polls =  self.polls.where(:poll_type => 'location')
    if @location_polls.present?
      return true
    end
    return false
  end

  def location_polls
    return self.polls.where(:poll_type => 'location')
  end

end
