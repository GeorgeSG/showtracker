require 'rails_helper'

describe ApplicationHelper do
  describe "#glyphicon" do
    it "creates a span element for a bootstrap glyphicon" do
      expect(helper.glyphicon('cog')).to be == "<span class=\"glyphicon glyphicon-cog\"></span>"
    end
  end
end