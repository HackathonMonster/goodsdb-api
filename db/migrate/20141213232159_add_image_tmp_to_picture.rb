class AddImageTmpToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :image_tmp, :string
    add_column :pictures, :image_processing, :boolean, null: false, default: false
  end
end
