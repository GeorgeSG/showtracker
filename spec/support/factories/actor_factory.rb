FactoryGirl.define do
  factory :actor do
    name { Faker::Name.name }
  end
end