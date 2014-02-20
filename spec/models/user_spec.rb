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
    before :each do
      @user = build(:user).save
    end

    it 'retrieves all shows for this user' do
      show_one = build(:show).save
      show_two = build(:show).save
      usershow_one = build(:usershow, show: show_one, user: @user).save
      usershow_two = build(:usershow, show: show_two, user: @user).save

      @user.shows.should =~ [show_one, show_two]

      usershow_one.destroy
      usershow_two.destroy
      show_one.destroy
      show_two.destroy

      @user.refresh
      @user.shows.should be_empty
    end

    it 'checks whether a user has a show' do
      show = build(:show).save
      usershow = build(:usershow, show: show, user: @user).save

      @user.has_show?(show.id).should be_true

      usershow.destroy
      show.destroy
    end

    it 'checks whether a user has watched an episode' do
      episode = build(:episode, episode_number: 3).save
      show = build(:show).save
      show.add_episode episode

      usershow = build(:usershow, show: show, user: @user, season: 3, episode: 2).save

      episode.refresh
      show.refresh
      usershow.refresh
      @user.refresh

      @user.watched?(1, episode).should be_true
      @user.watched?(2, episode).should be_true
      @user.watched?(3, episode).should be_false
      @user.watched?(0, episode).should be_false
      @user.watched?(4, episode).should be_false

      episode.destroy
      show.destroy
    end

    after :each do
      @user.destroy
    end
  end
end
