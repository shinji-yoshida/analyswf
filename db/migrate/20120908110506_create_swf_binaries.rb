class CreateSwfBinaries < ActiveRecord::Migration
  def change
    create_table :swf_binaries do |t|
      t.binary :data
      t.references :swf

      t.timestamps
    end
    add_index :swf_binaries, :swf_id
  end
end
