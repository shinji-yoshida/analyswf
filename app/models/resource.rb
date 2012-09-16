class Resource < ActiveRecord::Base
  attr_accessible :data
end

# == Schema Information
#
# Table name: resources
#
#  id         :integer          not null, primary key
#  data       :binary
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

