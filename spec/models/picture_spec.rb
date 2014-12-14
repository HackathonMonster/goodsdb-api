# == Schema Information
#
# Table name: pictures
#
#  id               :integer          not null, primary key
#  image            :string(255)
#  item_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  info             :text
#  image_tmp        :string(255)
#  image_processing :boolean          default(FALSE), not null
#

require 'rails_helper'

describe Picture, type: :model do
  subject(:picture) { create(:picture) }

  it { is_expected.to respond_to(:image) }

  it { is_expected.to belong_to(:item) }
  it { is_expected.to validate_presence_of(:item) }
end
