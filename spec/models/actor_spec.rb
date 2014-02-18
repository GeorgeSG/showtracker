require_relative '../spec_helper'

describe Genre do
  it 'has a valid factory' do
    build(:actor).should be_valid
  end

  context 'Validations' do
    it 'is invalid without a name' do
      build(:actor, name: nil).should_not be_valid
    end
  end

  context 'Queries' do
    it 'retrieves all shows for the actor'
    it 'finds an actor by id'
  end
end
