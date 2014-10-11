FactoryGirl.define do
  factory :user do
    email   { Faker::Internet.safe_email }
    password "fakepassw0rd"
    password_confirmation "fakepassw0rd"

    confirmed_at { Time.zone.now }
  end
end