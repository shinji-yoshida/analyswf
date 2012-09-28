module CustomSwfParameterMatchers

  def be_jpeg_swf_parameter(expected_map)
    BeImageSwfParameter.new(Replacement::JpegSwfParameter.new(expected_map))
  end

  def be_gif_swf_parameter(expected_map)
    BeImageSwfParameter.new(Replacement::GifSwfParameter.new(expected_map))
  end

  class BeImageSwfParameter
    def initialize(expected)
      @expected = expected
    end

    def matches?(target)
      @target = target
      return false unless @target.kind_of?(@expected.class)
      return false unless @target.offset == @expected.offset
      return false unless @target.test_resource_name == @expected.test_resource_name
      return true
    end

    def failure_message
      "expected #{@target.inspect} to be #{@expected.inspect}"
    end
    
    def negative_failure_message
      "expected #{@target.inspect} not to be #{@expected.inspect}"
    end
  end

end