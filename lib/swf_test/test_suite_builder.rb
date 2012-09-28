# -*- encoding: utf-8 -*-
require 'swf_test/test_suite'
require 'swf_test/test_case_builder'

module SwfTest
  class TestSuiteBuilder
    def initialize(context)
      @context = context
      @test_cases = []
    end

    def to_test(description, &block)
      test_case_builder = TestCaseBuilder.new(@context)
      test_case_builder.set_description description
      test_case_builder.instance_eval &block
      @test_cases.push test_case_builder.create
    end

    def eval_script(script)
      instance_eval(script)
      TestSuite.new @test_cases
    end

    def get_test_cases
      @test_cases.clone
    end
  end
end

# 想定するテスト用スクリプト :
#
# to_test 'id:foo 画像を bar サンプル画像で置き換えられることを確かめる' do
#   replace_jpeg 'foo', with: 'bar'
# end
#
# to_test 'id:hoge 画像が置き換えられていることを確かめる' do
#   replace_gif 'hoge', with: 'fuga'
#   replace_control 'card_num', with: 3
#   check '右端のカード画像が fuga サンプル画像になっている'
# end