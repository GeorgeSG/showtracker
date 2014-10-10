FactoryGirl.define do
  factory :network do |f|
    f.name   { Faker::Lorem.word }
  end
end
