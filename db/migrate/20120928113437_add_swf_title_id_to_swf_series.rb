class AddSwfTitleIdToSwfSeries < ActiveRecord::Migration
  def change
    add_column :swf_series, :swf_title_id, :integer
    add_index :swf_series, :swf_title_id
  end
end
