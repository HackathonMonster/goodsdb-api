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

  attr_accessor :score

  has_and_belongs_to_many :tags, -> { uniq }

  validates :owner, presence: true

  scope :with_events, (lambda do
    joins(:item_events)
      .group(ItemEvent.arel_table[:item_id], arel_table[:id])
      .having(ItemEvent.arel_table[:item_id].count.gt(0))
  end)

  scope :found, -> { with_events.merge(ItemEvent.found) }
  scope :lost, -> { with_events.merge(ItemEvent.lost) }
  scope :lost_and_found, -> { found.merge(ItemEvent.lost) }

  scope :with_any_tag, (lambda do |tags|
    joins(:tags)
      .group(arel_table[:id], Tag.arel_table[:name], Tag.arel_table[:id])
      .having(Tag.arel_table[:name].in(tags))
  end)

  def self.search_items(items, tags)
    items = items.with_any_tag(tags).includes(:tags)
    items.each do |item|
      tags = item.tags.map(&:name) # avoid DB query
      item.score = (tags.to_set & tags).size
    end
    items.sort { |x, y| y.score <=> x.score }
  end

  def self.search(tags, status = 'any')
    case status
    when 'lost' then search_lost(tags)
    when 'found' then search_found(tags)
    when 'lost_and_found' then search_lost_and_found(tags)
    else search_items(with_events, tags)
    end
  end

  def self.search_found(tags)
    search_items(found, tags)
  end

  def self.search_lost(tags)
    search_items(lost, tags)
  end

  def self.search_lost_and_found(tags)
    search_items(lost_and_found, tags)
  end

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
