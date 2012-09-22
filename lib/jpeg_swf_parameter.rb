require 'image_swf_parameter'

class JpegSwfParameter < ImageSwfParameter
  def self.type
    return TargetType::JPEG
  end

  def self.create(map)
    JpegSwfParameter.new(map)
  end
end