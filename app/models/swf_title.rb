class SwfTitle < ActiveRecord::Base
  has_many :swf_series
  belongs_to :latest_swf_series, class_name: "SwfSeries"
  belongs_to :latest_swf, class_name: "Swf"

  def latest_swf_series
    swf_series.order_by_version_desc.limit(1).first
  end
end

# == Schema Information
#
# Table name: swf_titles
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  latest_swf_series_id :integer
#  latest_swf_id        :integer
#

