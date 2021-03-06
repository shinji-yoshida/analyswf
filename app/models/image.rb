class Image < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :content
  has_attached_file :content, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates :name, :uniqueness => true
  validates :content, :attachment_presence => true

  def image_type
    if content_content_type == 'image/jpeg'
      TargetType::JPEG
    elsif content_content_type == 'image/gif'
      TargetType::GIF
    end
  end
end

# == Schema Information
#
# Table name: images
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
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

