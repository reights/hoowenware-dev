class Poll < ActiveRecord::Base
  belongs_to :trip
  has_many :poll_responses

  validates :title, :presence => true
  validates :poll_type,  :presence => true
end
