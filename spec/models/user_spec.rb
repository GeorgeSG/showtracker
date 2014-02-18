require_relative '../spec_helper'

describe User do
  it 'has a valid factory' do
    build(:user).should be_valid
  end

  context 'Full name' do
    it 'returns a user\'s full name as a string' do
      names = { first_name: 'John', last_name: 'Doe' }
      build(:user, names).full_name.should == 'John Doe'
    end

    it 'returns a users\s full name with only first name' do
      names = { first_name: 'John', last_name: nil }
      build(:user, names).full_name.should == 'John'
    end

    it 'returns a users\s full name with only last name' do
      names = { first_name: nil, last_name: 'Doe' }
      build(:user, names).full_name.should == 'Doe'
    end
  end

  context 'Validations' do
    it 'is invalid without a username' do
      build(:user, username: nil).should_not be_valid
    end

    it 'is invalid without a password' do
      build(:user, password: nil).should_not be_valid
    end

    it 'is invalid without a password hash' do
      build(:user, salt: nil).should_not be_valid
    end
  end

  context 'Shows' do
    it 'retrieves all shows for this user'
    it 'checks whether a user has a show'
  end
end
