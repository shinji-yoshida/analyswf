class AddContentColumnsToImages < ActiveRecord::Migration
  def up
    add_attachment :images, :content
  end

  def down
    remove_attachment :images, :content
  end
end
