require './fake_helpers'
require 'bcrypt'

users = DB[:users].delete

20.times do
  name = Faker::Name.first_name
  password_salt = BCrypt::Engine.generate_salt
  password_hash = BCrypt::Engine.hash_secret(name, password_salt)

  User.create(
    username: name,
    salt: password_salt,
    password: password_hash,
    first_name: name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email
  )
end
