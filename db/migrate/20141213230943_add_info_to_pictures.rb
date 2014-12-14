class AddInfoToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :info, :text
  end
end
