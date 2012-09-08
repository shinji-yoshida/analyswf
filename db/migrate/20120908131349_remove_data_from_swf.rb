class RemoveDataFromSwf < ActiveRecord::Migration
  def up
    remove_column :swfs, :data
  end

  def down
    add_column :swfs, :data, :binary
  end
end
