class AddSwfSeriesIdToSwf < ActiveRecord::Migration
  def change
    add_column :swfs, :swf_series_id, :integer
  end
end
