class AddLatestSwfSeriesIdToSwfTitle < ActiveRecord::Migration
  def change
    add_column :swf_titles, :latest_swf_series_id, :integer
  end
end
