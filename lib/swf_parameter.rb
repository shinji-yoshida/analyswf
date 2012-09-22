class SwfParameter
  ENCODING_PREFIX = "swf_parameter_"

  def self.decode(key, value)
    if /^#{ENCODING_PREFIX}#{JpegSwfParameter::type}/ =~ key
      return JpegSwfParameter.decode(key, value)
    elsif /^#{ENCODING_PREFIX}#{GifSwfParameter::type}/ =~ key
      return GifSwfParameter.decode(key, value)
    end
  end

  def self.decode_params(params)
    return params.select{|k, v| start_with_encoding_prefix?(k)}.map do |k, v|
      decode(k, v)
    end
  end

  def type
    return self.class.type
  end

  def encode
    raise 'should implement in subclass'
  end

  protected

  def self.start_with_encoding_prefix?(s)
    /^#{ENCODING_PREFIX}/ =~ s
  end
end

require 'jpeg_swf_parameter'
require 'gif_swf_parameter'