class AddCounterToItems < ActiveRecord::Migration
  def change
    add_column :items, :cached_votes_up, :integer, default: 0, null: false
    add_index :items, :cached_votes_up
  end
end
