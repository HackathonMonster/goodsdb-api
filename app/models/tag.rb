# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  item_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base
  has_and_belongs_to_many :items

  def self.from_names(names)
    return none if names.blank?
    tags = where(arel_table[:name].in(names))
    new_tags = names.to_set - tags.pluck(:name)
    new_tags.each do |name|
      tags << Tag.create(name: name)
    end
    tags
  end
end
