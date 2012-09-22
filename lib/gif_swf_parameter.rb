require 'swf_parameter'

class GifSwfParameter < SwfParameter
  attr_reader :offset, :test_resource_name

  def initialize(map)
    @offset = map[:offset].to_i
    @test_resource_name = map[:test_resource_name]

    raise 'test_resource_name not given' if map[:test_resource_name].blank?
  end

  def self.type
    return TargetType::GIF
  end

  def encode
    return {"#{ENCODING_PREFIX}#{type}_#{offset}" => test_resource_name}
  end

  def self.decode(key, value)
    offset = key.sub(/#{ENCODING_PREFIX}#{self.type}/, "").to_i
    return GifSwfParameter.new(offset: offset, test_resource_name: value)
  end
end