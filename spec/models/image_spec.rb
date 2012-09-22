# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Image do
  describe 'image_type' do
    it 'content_content_type が image/jpeg なら、 TargetType::JPEG を返す' do
      subject = FactoryGirl.build(:image, content_content_type: 'image/jpeg')
      subject.image_type.should == TargetType::JPEG
    end

    it 'content_content_type が image/gif なら、 TargetType::GIF を返す' do
      subject = FactoryGirl.build(:image, content_content_type: 'image/gif')
      subject.image_type.should == TargetType::GIF
    end
  end
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

