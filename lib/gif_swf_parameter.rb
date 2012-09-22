require 'image_swf_parameter'

class GifSwfParameter < ImageSwfParameter
  def self.type
    return TargetType::GIF
  end

  def self.create(map)
    GifSwfParameter.new(map)
  end

  def create_replace_target
    SwfRuby::Lossless2ReplaceTarget.new(offset, File.binread(image_path))
  end
end