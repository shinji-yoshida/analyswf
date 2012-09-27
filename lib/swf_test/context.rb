require 'swf_test/target_not_found_error'
module SwfTest

  class Context
    def initialize(swf)
      @swf = swf
    end

    def offset(target)
      @swf.offsets.each do |o|
        return o.value if o.target_name == target
      end
      raise SwfTest::TargetNotFoundError.new
    end
  end

end