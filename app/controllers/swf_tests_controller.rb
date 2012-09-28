require 'swf_test/test_suite_builder'
require 'swf_test/context'

class SwfTestsController < ApplicationController
  before_filter :load_swf
  before_filter :load_test_suite

  def show
    @test_index = params[:id].to_i
  end

  def send_show
    test_index = params[:id].to_i

    response.headers["Content-Type"] = "application/x-shockwave-flash"
    send_data @test_suite.replace(test_index, @swf.swf_binary.data), :type => "swf", :disposition => 'inline'
  end

  private

  def load_swf
    @swf = Swf.find(params[:swf_id])
  end

  def load_test_suite
    @test_suite = SwfTest::TestSuiteBuilder.new(SwfTest::Context.new(@swf)).eval_script(@swf.swf_series.test_script)
  end
end
