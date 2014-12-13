class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.belongs_to :owner

      t.timestamps
    end
    add_index :items, :owner_id
  end
end
