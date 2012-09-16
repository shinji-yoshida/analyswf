class Image < ActiveRecord::Base
  belongs_to :resource
  attr_accessible :image_type, :name
end

# == Schema Information
#
# Table name: images
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  image_type  :string(255)
#  resource_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_images_on_resource_id  (resource_id)
#
