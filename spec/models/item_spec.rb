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

require 'rails_helper'

describe Item, type: :model do
  subject(:item) { create(:item) }

  it { is_expected.to respond_to(:name) }

  it { is_expected.to belong_to(:owner) }
end
