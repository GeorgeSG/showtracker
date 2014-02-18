FactoryGirl.define do
  factory :user do |f|
    password = Faker::Internet.password
    salt     = BCrypt::Engine.generate_salt
    password = BCrypt::Engine.hash_secret(password, salt)

    f.username   { Faker::Internet.user_name }
    f.password   { password }
    f.salt       { salt }
    f.email      { Faker::Internet.email }
    f.first_name { Faker::Name.first_name }
    f.last_name  { Faker::Name.last_name }
  end
end
