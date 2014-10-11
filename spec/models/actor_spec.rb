require 'rails_helper'

describe Actor do
  subject { create :actor }

  context "validations" do
    it { should validate_presence_of(:name) }
  end

  context "shows" do
    let (:network) { create :network }
    let (:show_1) { create :show, network: network }
    let (:show_2) { create :show, network: network }

    it "can have many shows" do
      expect {
        subject.shows << show_1 << show_2
      }.to change { subject.shows.count }.from(0).to(2)

      expect(subject.shows).to include(show_1, show_2)
    end
  end
end