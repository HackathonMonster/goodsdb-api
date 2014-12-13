# == Schema Information
#
# Table name: pictures
#
#  id         :integer          not null, primary key
#  image      :string(255)
#  item_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Picture < ActiveRecord::Base
  belongs_to :item

  validates :item, presence: true

  mount_uploader :image, ImageUploader

  def self.build_all(images, item)
    return none if images.blank?
    images.each do |image|
      item.pictures.build(image: image)
    end
  end
end
