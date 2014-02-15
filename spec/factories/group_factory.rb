# group factory for integration testing

FactoryGirl.define do
  factory :group do
    name { generate(:group_name) }
  end
end