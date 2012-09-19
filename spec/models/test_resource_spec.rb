require 'spec_helper'

describe TestResource do
end

# == Schema Information
#
# Table name: test_resources
#
#  id            :integer          not null, primary key
#  swf_series_id :integer
#  image_id      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_test_resources_on_image_id       (image_id)
#  index_test_resources_on_swf_series_id  (swf_series_id)
#

