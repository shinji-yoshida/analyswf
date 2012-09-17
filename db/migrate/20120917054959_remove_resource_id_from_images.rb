class RemoveResourceIdFromImages < ActiveRecord::Migration
  def up
    remove_column :images, :resource_id
  end

  def down
    add_column :images, :resource_id, :integer
  end
end
