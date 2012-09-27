# -*- encoding: utf-8 -*-
require 'swf_test/test_case_builder'

describe SwfTest::TestCaseBuilder do
  include(CustomSwfParameterMatchers)

  let(:context) {SwfTest::Context.new(nil)}
  let(:subject) {SwfTest::TestCaseBuilder.new(context)}

  describe 'replace_jpeg' do
    before do
      @offset_hoge = 3
      @offset_foo = 5
      context.stub(:offset).with('hoge').and_return @offset_hoge
      context.stub(:offset).with('foo').and_return @offset_foo
    end

    it '複数の JpegSwfParameter を生成できる' do
      subject.replace_jpeg 'hoge', with: 'fuga'
      subject.replace_jpeg 'foo', with: 'bar'

      subject.get_swf_parameter('hoge').should be_jpeg_swf_parameter(offset: @offset_hoge, test_resource_name: 'fuga')
      subject.get_swf_parameter('foo').should be_jpeg_swf_parameter(offset: @offset_foo, test_resource_name: 'bar')
    end

    it '同じ target は一度しか指定できない' do
      subject.replace_gif 'hoge', with: 'fuga'
      expect{
        subject.replace_jpeg 'hoge', with: 'bar'}.to raise_error SwfTest::TargetAlreadyReplacedError
    end
  end

  describe 'replace_gif' do
    before do
      @offset_hoge = 3
      @offset_foo = 5
      context.stub(:offset).with('hoge').and_return @offset_hoge
      context.stub(:offset).with('foo').and_return @offset_foo
    end

    it '複数の GifSwfParameter を生成できる' do
      subject.replace_gif 'hoge', with: 'fuga'
      subject.replace_gif 'foo', with: 'bar'

      subject.get_swf_parameter('hoge').should be_gif_swf_parameter(offset: @offset_hoge, test_resource_name: 'fuga')
      subject.get_swf_parameter('foo').should be_gif_swf_parameter(offset: @offset_foo, test_resource_name: 'bar')
    end

    it '同じ target は一度しか指定できない' do
      subject.replace_jpeg 'hoge', with: 'fuga'
      expect{
        subject.replace_gif 'hoge', with: 'bar'}.to raise_error SwfTest::TargetAlreadyReplacedError
    end
  end
end