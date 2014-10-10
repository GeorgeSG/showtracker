FactoryGirl.define do
  factory :usershow do |f|
    f.season { Faker::Number.digit }
    f.episode { Faker::Number.digit }
    f.show { Show.all.sample }
    f.user { User.all.sample }
  end
end
