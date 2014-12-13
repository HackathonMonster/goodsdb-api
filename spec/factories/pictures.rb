# == Schema Information
#
# Table name: pictures
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  item_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :picture do
    sequence(:image) { |n| "http://example.com/dummy-url-#{n}" }
    item
  end
end
