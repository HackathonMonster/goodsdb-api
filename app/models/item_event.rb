# == Schema Information
#
# Table name: item_events
#
#  id         :integer          not null, primary key
#  status     :integer          default(0), not null
#  item_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class ItemEvent < ActiveRecord::Base
  include FlagShihTzu

  belongs_to :item

  has_flags 1 => :lost, 2 => :found, 3 => :done, column: 'status'

  default_scope { not_done }
end
