FactoryGirl.define do
  factory :actor do |f|
    f.name { Faker::Name.first_name + ' ' + Faker::Name.last_name }
  end
end
