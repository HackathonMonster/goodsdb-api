# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe Tag, type: :model do
  subject(:tag) { create(:tag) }

  it { is_expected.to respond_to(:name) }

  describe '#from_names' do
    let!(:tag) { create(:tag, name: 'foo') }
    let!(:other_tag) { create(:tag, name: 'bar') }

    it 'should not add existing tags' do
      tags = Tag.from_names(['foo'])
      expect(Tag.count).to eq(2)
      expect(tags.pluck(:name)).to include('foo')
      expect(tags.pluck(:name)).not_to include('bar')
    end

    it 'should add unexisting tags' do
      tags = Tag.from_names(['newtag'])
      expect(Tag.count).to eq(3)
      expect(tags.pluck(:name)).to include('newtag')
    end
  end
end
