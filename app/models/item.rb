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
  has_and_belongs_to_many :tags

  validates :owner, presence: true

  def self.build_from_attributes(params)
    tags = params.delete :tags
    pictures = params.delete :pictures
    item = new(params.permit(:name))
    item.tags = Tag.from_names(tags)
    Picture.build_all(pictures, item)
    item
  end
end
