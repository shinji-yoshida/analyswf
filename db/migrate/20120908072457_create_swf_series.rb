class CreateSwfSeries < ActiveRecord::Migration
  def change
    create_table :swf_series do |t|
      t.string :name
      t.integer :version
      t.text :data

      t.timestamps
    end
  end
end
