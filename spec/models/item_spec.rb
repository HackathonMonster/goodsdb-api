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
  it { is_expected.to have_many(:pictures) }
  it { is_expected.to have_many(:item_events) }
  it { is_expected.to have_and_belong_to_many(:tags) }

  it { is_expected.to validate_presence_of(:owner) }

  describe '#from_params' do
    let(:user) { create(:user) }
    let(:params) { ActionController::Parameters.new(name: 'foobar', tags: %w(foo bar)) }

    it 'should create new tags' do
      item = user.items.build_from_attributes(params)
      expect(item.save).to be_truthy
    end
  end
end
