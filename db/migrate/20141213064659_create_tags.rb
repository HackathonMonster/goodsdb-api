class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end
    add_index :tags, :name, unique: true

    create_join_table :items, :tags do |t|
      t.index :item_id
      t.index :tag_id
    end
  end
end
