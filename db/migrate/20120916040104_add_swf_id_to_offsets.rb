class AddSwfIdToOffsets < ActiveRecord::Migration
  def change
    add_column :offsets, :swf_id, :integer
    add_index :offsets, :swf_id
  end
end
