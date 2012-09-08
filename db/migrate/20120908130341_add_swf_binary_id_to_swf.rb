class AddSwfBinaryIdToSwf < ActiveRecord::Migration
  def change
    add_column :swfs, :swf_binary_id, :integer
  end
end
