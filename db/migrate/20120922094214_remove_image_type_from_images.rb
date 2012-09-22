class RemoveImageTypeFromImages < ActiveRecord::Migration
  def up
    remove_column :images, :image_type
  end

  def down
    add_column :images, :image_type, :string
  end
end
