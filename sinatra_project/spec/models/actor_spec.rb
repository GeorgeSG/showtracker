require_relative '../spec_helper'

describe Actor do
  it 'has a valid factory' do
    build(:actor).should be_valid
  end

  context 'Validations' do
    it 'is invalid without a name' do
      build(:actor, name: nil).should_not be_valid
    end
  end

  context 'Queries' do
    before :each do
      @actor = build(:actor).save
    end

    it 'retrieves all shows for the actor' do
      show_one = build(:show).save
      show_two = build(:show).save

      @actor.add_show show_one
      @actor.add_show show_two
      @actor.save

      @actor.shows.should =~ [show_one, show_two]

      show_one.destroy
      show_two.destroy

      @actor.refresh
      @actor.shows.should be_empty
    end

    it 'finds an actor by id' do
      Actor.with_id(@actor.id).should == @actor
    end

    after :each do
      @actor.destroy
    end
  end
end
