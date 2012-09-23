require 'swf_ruby'

class SwfProcessor
  attr_accessor :swf_binary

  def initialize(swf_binary)
    @swf_binary = swf_binary
  end

  def replace(swf_parameters)
    replace_images(swf_parameters)
  end

  def replace_images(image_swf_parameters)
    SwfRuby::SwfTamperer.new.replace(swf_binary, image_swf_parameters.map(&:create_replace_target))
  end
end