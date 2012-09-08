class AddIndexToSwfSeries < ActiveRecord::Migration
  def change
    add_index :swf_series, :name
  end
end
