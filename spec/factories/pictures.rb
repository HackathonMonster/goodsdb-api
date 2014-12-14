# == Schema Information
#
# Table name: pictures
#
#  id               :integer          not null, primary key
#  image            :string(255)
#  item_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  info             :text
#  image_tmp        :string(255)
#  image_processing :boolean          default(FALSE), not null
#

FactoryGirl.define do
  factory :picture do
    sequence(:image) { |n| "http://example.com/dummy-url-#{n}" }
    item
  end
end
