class SwfSeries < ActiveRecord::Base
  attr_accessible :data, :name, :version
  store :data, accessors: [:targets]

  has_many :swfs

  after_initialize :default_value

  def put_target(name, target_type)
    self.targets[name] = target_type
  end

  def get_target(name)
    self.targets[name]
  end

  private

  def default_value
    self.targets ||= {}
  end
end

# == Schema Information
#
# Table name: swf_series
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  version    :integer
#  data       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_swf_series_on_name  (name)
#

