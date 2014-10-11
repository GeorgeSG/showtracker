FactoryGirl.define do
  factory :network do
    NETWORKS = [
      'ABC',
      'NBC',
      'Fox',
      'CBS',
      'PBS'
    ].freeze

    name { NETWORKS.sample }
  end
end