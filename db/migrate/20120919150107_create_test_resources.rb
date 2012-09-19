class CreateTestResources < ActiveRecord::Migration
  def change
    create_table :test_resources do |t|
      t.references :swf_series
      t.references :image

      t.timestamps
    end
    add_index :test_resources, :swf_series_id
    add_index :test_resources, :image_id
  end
end
