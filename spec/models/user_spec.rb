require 'rails_helper'

describe User do
  it { should have_many(:subscriptions) }
  it { should have_many(:shows).through(:subscriptions) }
end
