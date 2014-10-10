require_relative '../spec_helper'

describe Network do
  it 'has a valid factory' do
    build(:network).should be_valid
  end

  context 'Validations' do
    it 'is invalid without a name' do
      build(:network, name: nil).should_not be_valid
    end
  end

  context 'Queries' do
    before :each do
      @network = build(:network).save
    end

    it 'retrieves all shows in the network' do
      show_one = build(:show).save
      show_two = build(:show).save

      @network.add_show show_one
      @network.add_show show_two
      @network.save

      @network.shows.should =~ [show_one, show_two]

      show_one.destroy
      show_two.destroy

      @network.refresh
      @network.shows.should be_empty
    end

    it 'finds a network by id' do
      Network.with_id(@network.id).should == @network
    end

    after :each do
      @network.destroy
    end
  end
end
