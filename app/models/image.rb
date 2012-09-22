class Image < ActiveRecord::Base
  attr_accessible :image_type, :name
  attr_accessible :content
  has_attached_file :content, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end

# == Schema Information
#
# Table name: images
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  image_type           :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  content_file_name    :string(255)
#  content_content_type :string(255)
#  content_file_size    :integer
#  content_updated_at   :datetime
#
# Indexes
#
#  index_images_on_name  (name) UNIQUE
#

