# membership factory for integration testing

FactoryGirl.define do
  factory :membership do
    group_id { generate(:group_id) }
    email { generate(:membership_email) }
    is_active true
    is_admin false
  end
end