class CreateItemEvents < ActiveRecord::Migration
  def change
    create_table :item_events do |t|
      t.integer :status, null: false, default: 0
      t.belongs_to :item

      t.index :status
      t.index :item_id

      t.timestamps
    end
  end
end
