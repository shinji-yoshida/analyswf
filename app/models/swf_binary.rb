class SwfBinary < ActiveRecord::Base
  belongs_to :swf
  attr_accessible :data
end
