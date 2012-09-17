class DestroyResources < ActiveRecord::Migration
  def up
    drop_table :resources
  end

  def down
    create_table :resources do |t|
      t.binary :data

      t.timestamps
    end
  end
end
