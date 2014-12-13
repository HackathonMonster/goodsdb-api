class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :url
      t.belongs_to :item

      t.timestamps
    end
    add_index :pictures, :item_id
  end
end
