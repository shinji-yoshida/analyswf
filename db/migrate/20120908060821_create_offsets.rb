class CreateOffsets < ActiveRecord::Migration
  def change
    create_table :offsets do |t|
      t.integer :value
      t.string :type

      t.timestamps
    end
  end
end
