require 'image_swf_parameter'

class GifSwfParameter < ImageSwfParameter
  def self.type
    return TargetType::GIF
  end

  def self.create(map)
    GifSwfParameter.new(map)
  end
end