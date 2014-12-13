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

require 'rails_helper'

describe ItemEvent, type: :model do
  subject(:item_event) { create(:item_event) }

  it { is_expected.to respond_to(:status) }

  it { is_expected.to belong_to(:item) }
end
