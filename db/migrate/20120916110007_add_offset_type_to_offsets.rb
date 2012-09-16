class AddOffsetTypeToOffsets < ActiveRecord::Migration
  def change
    add_column :offsets, :offset_type, :string
  end
end
