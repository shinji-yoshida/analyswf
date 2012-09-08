class Swf < ActiveRecord::Base
  attr_accessible :data
  belongs_to :swf_series
  has_one :swf_binary
end

# == Schema Information
#
# Table name: swfs
#
#  id            :integer          not null, primary key
#  data          :binary
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  swf_series_id :integer
#  swf_binary_id :integer
#

