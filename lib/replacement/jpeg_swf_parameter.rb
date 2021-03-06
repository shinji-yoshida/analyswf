require 'replacement/image_swf_parameter'

module Replacement
  class JpegSwfParameter < ImageSwfParameter
    def self.type
      return TargetType::JPEG
    end

    def self.create(map)
      JpegSwfParameter.new(map)
    end

    def create_replace_target
      SwfRuby::Jpeg2ReplaceTarget.new(offset, File.binread(image_path))
    end
  end
end