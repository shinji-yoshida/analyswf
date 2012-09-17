class AddTargetNameToOffsets < ActiveRecord::Migration
  def change
    add_column :offsets, :target_name, :string
  end
end
