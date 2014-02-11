class Trip < ActiveRecord::Base
  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :location, presence: true

  belongs_to :user
  has_many :permissions, as: :thing
  scope :viewable_by, ->(user) do
    joins(:permissions).where(permissions: { action: "view", user_id: user.id })
  end
end
