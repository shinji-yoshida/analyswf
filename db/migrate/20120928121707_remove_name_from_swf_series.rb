class RemoveNameFromSwfSeries < ActiveRecord::Migration
  def up
    remove_column :swf_series, :name
  end

  def down
    add_column :swf_series, :name, :string
  end
end
