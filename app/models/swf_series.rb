class SwfSeries < ActiveRecord::Base
  store :data, accessors: [:targets]

  has_many :swfs
  has_many :test_resources
  belongs_to :swf_title

  validates :swf_title, presence: true

  delegate :name, to: :swf_title

  scope :order_by_version_desc, order('version DESC')

  after_initialize :default_value

  def put_target(name, target_type)
    self.targets[name] = target_type
  end

  def get_target(name)
    self.targets[name]
  end

  def jpeg_target_names
    target_names(TargetType::JPEG)
  end

  def gif_target_names
    target_names(TargetType::GIF)
  end

  def target_names(target_type)
    targets_for(target_type).keys
  end

  def jpeg_targets
    targets_for(TargetType::JPEG)
  end

  def gif_targets
    targets_for(TargetType::GIF)
  end

  def targets_for(target_type)
    targets.select{|name, type| type == target_type}
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
#  id           :integer          not null, primary key
#  version      :integer
#  data         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  test_script  :text             default(""), not null
#  swf_title_id :integer
#
# Indexes
#
#  index_swf_series_on_swf_title_id  (swf_title_id)
#

