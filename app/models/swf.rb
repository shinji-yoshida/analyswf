class Swf < ActiveRecord::Base
  attr_accessible :data
  belongs_to :swf_series
  has_one :swf_binary
  has_many :offsets

  def jpeg_offsets
    offsets.select{|o| o.offset_type == TargetType::JPEG}
  end

  def gif_offsets
    offsets.select{|o| o.offset_type == TargetType::GIF}
  end
end

# == Schema Information
#
# Table name: swfs
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  swf_series_id :integer
#

