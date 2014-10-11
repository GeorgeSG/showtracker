require 'rails_helper'

describe Show do
  it { should have_many(:subscriptions) }
  it { should have_many(:users).through(:subscriptions) }
  it { should have_many(:episodes) }
  it { should have_and_belong_to_many(:actors) }
  it { should have_and_belong_to_many(:genres) }
  it { should belong_to(:network) }

  let (:network) { create :network }
  subject { create :show, network: network }

  describe "#create" do
    context "validations" do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:network) }
    end

    context "without network" do
      it "does not save" do
        expect { Show.create }.not_to change(Show, :count)
      end
    end

    context "default values" do
      its (:rating) { should be_zero }
      its (:rating_count) { should be_zero }
    end
  end

  describe "#network" do
    its (:network) { should == network }
  end

  describe "#actors" do
    let (:actor_a) { create :actor }
    let (:actor_b) { create :actor }

    it "can have multiple actors" do
      subject.actors << actor_a << actor_b

      expect(subject.actors.count).to be 2
      expect(subject.actors).to include(actor_a, actor_b)
    end
  end

  describe "#genres" do
    let (:genre_a) { create :genre, name: "Show Genre A" }
    let (:genre_b) { create :genre, name: "Show Genre B" }

    it "can have multiple genres" do
      subject.genres << genre_a << genre_b

      expect(subject.genres.count).to be 2
      expect(subject.genres).to include(genre_a, genre_b)
    end
  end

  describe "#subscriptions" do
    let (:user) { create :user }
    let (:subscription) { create :subscription, show: subject, user: user}

    it "can have a subscription" do
      expect(subject.subscriptions).to include(subscription)
    end
  end


  describe "#top_rated" do
    pending "should show the 10 top rated shows"
  end
end