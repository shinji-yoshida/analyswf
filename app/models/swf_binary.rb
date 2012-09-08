class SwfBinary < ActiveRecord::Base
  belongs_to :swf
  attr_accessible :data
end

# == Schema Information
#
# Table name: swf_binaries
#
#  id         :integer          not null, primary key
#  data       :binary
#  swf_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_swf_binaries_on_swf_id  (swf_id)
#

