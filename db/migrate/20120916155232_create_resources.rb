class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.binary :data

      t.timestamps
    end
  end
end
