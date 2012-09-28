class CreateSwfTitles < ActiveRecord::Migration
  def change
    create_table :swf_titles do |t|
      t.string :name

      t.timestamps
    end
  end
end
