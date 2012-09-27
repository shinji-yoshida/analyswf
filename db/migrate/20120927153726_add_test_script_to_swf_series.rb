class AddTestScriptToSwfSeries < ActiveRecord::Migration
  def change
    add_column :swf_series, :test_script, :text, null: false, default: ""
  end
end
