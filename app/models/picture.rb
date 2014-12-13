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

class Picture < ActiveRecord::Base
  belongs_to :item

  validates :item, presence: true
end
