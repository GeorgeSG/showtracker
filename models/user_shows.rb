class UserShow < Sequel::Model
  many_to_one :show
  many_to_one :user
end
