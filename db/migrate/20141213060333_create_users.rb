class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :display_name
      t.string :email
      t.string :profile_picture
      t.string :facebook_id
      t.string :facebook_token
      t.string :token

      t.timestamps
    end
    add_index :users, :facebook_id, unique: true
    add_index :users, :token, unique: true
  end
end
