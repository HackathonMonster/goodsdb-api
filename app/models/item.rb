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

class Item < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'

  has_many :pictures
  has_many :item_events

  attr_accessor :score, :liked

  has_and_belongs_to_many :tags, -> { uniq }

  validates :owner, presence: true

  acts_as_votable

  has_many :user_votes, -> { where(voter_type: 'User') }, foreign_key: 'votable_id', class_name: ActsAsVotable::Vote

  scope :with_events, (lambda do
    joins(:item_events)
      .group(ItemEvent.arel_table[:item_id], arel_table[:id], Tag.arel_table[:id])
      .having(ItemEvent.arel_table[:item_id].count.gt(0))
  end)

  scope :found, -> { with_events.merge(ItemEvent.found) }
  scope :lost, -> { with_events.merge(ItemEvent.lost) }
  scope :lost_and_found, -> { found.merge(ItemEvent.lost) }

  scope :with_pictures, (lambda do
    includes(:pictures).group(
      Picture.arel_table[:id], arel_table[:id], Tag.arel_table[:id]
    )
  end)

  scope :with_any_tag, (lambda do |tags|
    joins(:tags).merge(Tag.where(Tag.arel_table[:name].in(tags)))
  end)

  scope :liked_by, -> (user) { joins(:user_votes).merge(user.votes) }

  def self.filter_tags(tags)
    tags = tags.reject(&:blank?)
    return includes(:tags).joins(:tags) if tags.empty?
    items = with_any_tag(tags).includes(:tags)
    items.each do |item|
      tags = item.tags.map(&:name) # avoid DB query
      item.score = (tags.to_set & tags).size
    end
    items.sort { |x, y| y.score <=> x.score }
  end

  def self.filter_status(status = 'any')
    case status
    when 'lost' then lost
    when 'found' then found
    when 'lost_and_found' then lost_and_found
    else all
    end
  end

  def self.build_from_attributes(params)
    item = new(params.permit(:name))
    item.assign_params(params)
    item
  end

  def likes_count
    cached_votes_up
  end

  def assign_params(params)
    new_tags = params.delete :tags
    new_pictures = params.delete :pictures
    assign_attributes(params.permit(:name))
    self.tags = Tag.from_names(new_tags) unless new_tags.nil?
    self.pictures = Picture.build_all(new_pictures, self) unless new_pictures.nil?
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
