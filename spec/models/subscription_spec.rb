require 'rails_helper'

describe Subscription do
  it { should belong_to :show }
  it { should belong_to :user }

  let (:network) { create :network }
  let (:show) { create :show, network: network }
  let (:user) { create :user }

  subject { create :subscription, show: show, user: user }

  describe "#create" do
    context "rails validations" do
      it { should validate_presence_of :user }
      it { should validate_presence_of :show }
      it { should validate_uniqueness_of(:show_id).scoped_to(:user_id) }

      it "should validate uniqueness of user/show pairs" do
        expect {
          2.times { create :subscription, user: user, show: show }
        }.to raise_exception
      end
    end

    context "with no user and show" do
      it "does not save" do
        expect { Subscription.create }.not_to change(Subscription, :count)
        expect { Subscription.create user: user}.not_to change(Subscription, :count)
        expect { Subscription.create show: show}.not_to change(Subscription, :count)
      end
    end
  end

  context "default values" do
    its (:season) { should be_zero }
    its (:episode) { should be_zero }
  end
end