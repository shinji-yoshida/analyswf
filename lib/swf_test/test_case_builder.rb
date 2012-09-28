# -*- encoding: utf-8 -*-
require 'swf_test/target_already_replaced_error'
require 'replacement'

module SwfTest
  class TestCaseBuilder
    def initialize(context)
      @context = context
      @test_resource_name_map = {}
      @target_type_map = {}
      @check_items = []
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

    def check(text)
      @check_items.push text
    end

    def set_description(description)
      @description = description
    end

    def create
      parameters = @target_type_map.map{|target, type| create_swf_parameter(target)}
      TestCase.new(@description, parameters, @check_items)
    end

    def has_target?(target)
      @target_type_map.has_key?(target)
    end

    def create_swf_parameter(target)
      Replacement::ImageSwfParameter.create type: @target_type_map[target], offset: @context.offset(target), test_resource_name: @test_resource_name_map[target]
    end

    def get_swf_parameter(target)
      Replacement::ImageSwfParameter.create type: @target_type_map[target], offset: @context.offset(target), test_resource_name: @test_resource_name_map[target]
    end

    def get_check_items
      @check_items
    end
  end
end