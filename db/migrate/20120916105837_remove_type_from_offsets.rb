class RemoveTypeFromOffsets < ActiveRecord::Migration
  def up
    remove_column :offsets, :type
  end

  def down
    add_column :offsets, :type, :string
  end
end
