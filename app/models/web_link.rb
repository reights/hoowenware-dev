class WebLink < ActiveRecord::Base
  belongs_to :user
  validates               :user_id,   :presence => true
  validates               :url,       :presence => true
  validates_uniqueness_of :url,       :scope => :user_id
end