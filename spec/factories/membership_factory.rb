# membership factory for integration testing

FactoryGirl.define do
  sequence(:group_id) {|n| "#{n}"}
  sequence(:membership_email) {|n| "user#{n}@example.com"}

  factory :membership do
    group_id { generate(:group_id) }
    email { generate(:membership_email) }
    is_active true
    is_admin false
  end
end