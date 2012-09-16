class Offset < ActiveRecord::Base
  attr_accessible :offset_type, :value
  belongs_to :swf
end

# == Schema Information
#
# Table name: offsets
#
#  id          :integer          not null, primary key
#  value       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  swf_id      :integer
#  offset_type :string(255)
#
# Indexes
#
#  index_offsets_on_swf_id  (swf_id)
#

