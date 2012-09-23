require 'swf_processor'

module SwfTest

  class TestCase
    attr_reader :description

    def initialize(description, swf_parameters)
      @description = description
      @swf_parameters = swf_parameters
    end

    def replace(swf)
      SwfProcessor.new(swf).replace(@swf_parameters)
    end
  end

end