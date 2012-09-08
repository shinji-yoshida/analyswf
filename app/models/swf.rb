class Swf < ActiveRecord::Base
  attr_accessible :data
  belongs_to :swf_series
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
#

