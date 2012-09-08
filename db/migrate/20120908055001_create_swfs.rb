class CreateSwfs < ActiveRecord::Migration
  def change
    create_table :swfs do |t|
      t.binary :data

      t.timestamps
    end
  end
end
