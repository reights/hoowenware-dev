# grouo factory for integration testing

FactoryGirl.define do
  sequence(:name) {|n| "An Example Group ##{n}"}
  factory :group do
    name { generate(:name) }
  end
end