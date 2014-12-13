require 'spec_helper'

IGNORE_FACTORIES = [

]

FactoryGirl.factories.map(&:name).each do |factory_name|
  next if IGNORE_FACTORIES.include?(factory_name)
  describe "#{factory_name} factory" do
    it 'should be valid' do
      item = build(factory_name)
      expect(item).to be_valid
      expect(item.save).to be_truthy
    end
  end
end
