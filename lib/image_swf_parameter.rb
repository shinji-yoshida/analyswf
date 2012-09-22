require 'swf_parameter'

class ImageSwfParameter < SwfParameter
  attr_reader :offset, :test_resource_name

  def self.decode(key, value)
    offset = key.sub(/#{ENCODING_PREFIX}#{self.type}/, "").to_i
    return self.create(offset: offset, test_resource_name: value)
  end

  def self.create(map)
    raise 'should implement in subclass'
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
    TestResource.find_by_name(test_resource_name).image.content.path
  end
end