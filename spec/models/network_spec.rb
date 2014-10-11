require 'rails_helper'

describe Network do
  subject { create :network }

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  context "shows" do
    let (:show_1) { create :show, network: subject }
    let (:show_2) { create :show, network: subject }

    it "can have many shows" do
      expect {
        subject.shows << show_1 << show_2
      }.to change { subject.shows.count }.from(0).to(2)

      expect(subject.shows).to include(show_1, show_2)
    end
  end
end