require 'swf_test/test_case'

module SwfTest

  class SwfTest::TestSuite
    def initialize(test_cases)
      @test_cases = test_cases
    end

    def replace(index, swf)
      @test_cases[index].replace(swf)
    end

    def description(index)
      @test_cases[index].description
    end

    def size
      @test_cases.size
    end
  end

end