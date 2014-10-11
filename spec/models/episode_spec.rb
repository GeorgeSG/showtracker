require 'rails_helper'

describe Episode do
  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end 