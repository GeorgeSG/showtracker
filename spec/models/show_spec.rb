require 'rails_helper'

describe Show do
  subject { create :show }
  
  context "validations" do
    it { should validate_presence_of(:name) }
  end

  context "default values" do
    its (:rating) { should be_zero }
    its (:rating_count) { should be_zero }
  end
end 