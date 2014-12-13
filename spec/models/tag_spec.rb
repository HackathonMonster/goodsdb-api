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

require 'rails_helper'

describe Tag, type: :model do
  subject(:tag) { create(:tag) }

  it { is_expected.to respond_to(:name) }

  it { is_expected.to belong_to(:item) }
  it { is_expected.to validate_presence_of(:item) }
end
