class AddVersionToSwfs < ActiveRecord::Migration
  def change
    add_column :swfs, :version, :integer, null: false, default: 0
  end
end
