# == Schema Information
#
# Table name: item_events
#
#  id         :integer          not null, primary key
#  status     :integer          default(0), not null
#  item_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :item_event do
    status 0
    item
  end
end
