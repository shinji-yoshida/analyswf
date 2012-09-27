require 'swf_processor'

module SwfTest

  class TestCase
    attr_reader :description

    def initialize(description, swf_parameters, check_items = [])
      @description = description
      @swf_parameters = swf_parameters
      @check_items = check_items
    end

    def replace(swf)
      SwfProcessor.new(swf).replace(@swf_parameters)
    end

    def get_swf_parameters
      @swf_parameters.clone
    end

    def check_items
      @check_items.clone
    end
  end

end