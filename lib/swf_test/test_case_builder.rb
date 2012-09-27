# -*- encoding: utf-8 -*-
require 'swf_test/target_already_replaced_error'

module SwfTest
  class TestCaseBuilder
    def initialize(context)
      @context = context
      @test_resource_name_map = {}
      @target_type_map = {}
    end

    def replace_jpeg(target, map)
      raise TargetAlreadyReplacedError.new "already replaced : #{target}" if has_target?(target)
      test_resource_name = map[:with]
      raise SwfTest::Error.new "resource name not given for : #{target}" if test_resource_name.blank?

      @test_resource_name_map[target] = test_resource_name
      @target_type_map[target] = TargetType::JPEG
    end

    def replace_gif(target, map)
      raise TargetAlreadyReplacedError.new "already replaced : #{target}" if has_target?(target)
      test_resource_name = map[:with]
      raise SwfTest::Error.new "resource name not given for : #{target}" if test_resource_name.blank?

      @test_resource_name_map[target] = test_resource_name
      @target_type_map[target] = TargetType::GIF
    end

    def has_target?(target)
      @target_type_map.has_key?(target)
    end

    def get_swf_parameter(target)
      ImageSwfParameter.create type: @target_type_map[target], offset: @context.offset(target), test_resource_name: @test_resource_name_map[target]
    end
  end
end