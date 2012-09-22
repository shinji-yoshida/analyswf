class AddUniqueIndexToNameOfImages < ActiveRecord::Migration
  def change
    add_index :images, :name, unique: true
  end
end
