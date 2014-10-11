require 'rails_helper'

describe Episode do

  describe "#create" do
    context "validations" do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:show) }
    end

    context "without proper parameters" do
      it "does not save" do
        expect { Episode.create }.not_to change(Episode, :count)
      end
    end

    context "with parameters" do
      let (:show) { create :show, network: create(:network) }
      let (:params) { {name: Faker::Name.name, show: show, api_id: '1' } }

      it "saves" do
        expect { Episode.create params }.to change(Episode, :count)
      end
    end
  end
end