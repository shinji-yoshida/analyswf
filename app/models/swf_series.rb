class SwfSeries < ActiveRecord::Base
  attr_accessible :data, :name, :version
  store :data, accessors: [:targets]

  after_initialize :default_value


  module TargetType
    JPEG = 'jpeg'
    GIF = 'gif'
    MULTI_LINE_TEXT = 'multi_line_text'
    ONE_LINE_TEXT = 'one_line_text'
    CONTROL =  'control'
  end

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
