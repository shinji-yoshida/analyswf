class AddLatestSwfIdToSwfTitles < ActiveRecord::Migration
  def change
    add_column :swf_titles, :latest_swf_id, :integer
  end
end
