class RemoveSwfBinaryIdFromSwfs < ActiveRecord::Migration
  def up
    remove_column :swfs, :swf_binary_id
  end

  def down
    add_column :swfs, :swf_binary_id, :integer
  end
end
