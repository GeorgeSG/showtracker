FactoryGirl.define do
  factory :genre do |f|
    f.name   { Faker::Lorem.word }
  end
end
