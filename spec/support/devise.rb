# Adding devise support to RSpec

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
end