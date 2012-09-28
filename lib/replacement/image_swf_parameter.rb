require 'replacement/swf_parameter'
require 'swf_ruby'

module Replacement
  class ImageSwfParameter < SwfParameter
    attr_reader :offset, :test_resource_name

    def self.decode(key, value)
      _offset = key.sub(/#{ENCODING_PREFIX}#{self.type}_/, "").to_i
      return self.create(offset: _offset, test_resource_name: value)
    end

    def self.create(map)
      if map[:type] == TargetType::JPEG
        return JpegSwfParameter.create(map)
      elsif map[:type] == TargetType::GIF
        return GifSwfParameter.create(map)
      end
    end

    def initialize(map)
      @offset = map[:offset].to_i
      @test_resource_name = map[:test_resource_name]

      raise 'test_resource_name not given' if map[:test_resource_name].blank?
    end

    def encode
      return {"#{ENCODING_PREFIX}#{type}_#{offset}" => test_resource_name}
    end

    def create_replace_target
      raise 'should implement in subclass'
    end

    def image_path
      Image.find_by_name(test_resource_name).content.path
    end
  end
end