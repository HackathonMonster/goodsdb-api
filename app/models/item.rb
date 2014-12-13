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
  has_many :item_events

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

  def trigger_lost
    trigger_status(:lost)
  end

  def trigger_found
    trigger_status(:found)
  end

  def trigger_status(status)
    event = item_events.send(status).first
    return event unless event.nil?
    event = item_events.first_or_initialize
    event.send("#{status}=", true)
    event.save && event
  end
end
