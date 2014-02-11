class Membership < ActiveRecord::Base
  validates :email, presence: true

  belongs_to :groups
  has_many :users
  has_many :permissions, as: :thing
  scope :viewable_by, ->(user) do
    joins(:permissions).where(permissions: { action: "view", user_id: user.id })
  end

  def get_user
    @user = User.find_by(:email=> self.email)
    return @user
  end
end
