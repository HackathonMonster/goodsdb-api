# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  owner_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Item < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :pictures

  validates :owner, presence: true
end
