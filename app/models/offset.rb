class Offset < ActiveRecord::Base
  attr_accessible :type, :value
  belongs_to :swf
end

# == Schema Information
#
# Table name: offsets
#
#  id         :integer          not null, primary key
#  value      :integer
#  type       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  swf_id     :integer
#
# Indexes
#
#  index_offsets_on_swf_id  (swf_id)
#

