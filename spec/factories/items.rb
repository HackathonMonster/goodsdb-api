# == Schema Information
#
# Table name: items
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  owner_id        :integer
#  created_at      :datetime
#  updated_at      :datetime
#  cached_votes_up :integer          default(0), not null
#

FactoryGirl.define do
  factory :item do
    sequence(:name) { |n| "sample-name-#{n}" }
    owner
  end
end
