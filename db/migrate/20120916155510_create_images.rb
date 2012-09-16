class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.string :image_type
      t.references :resource

      t.timestamps
    end
    add_index :images, :resource_id
  end
end
