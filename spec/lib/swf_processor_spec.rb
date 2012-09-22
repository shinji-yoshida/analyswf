# -*- encoding: utf-8 -*-
require 'swf_processor'

describe SwfProcessor do
  let(:swf_processor) do
    SwfProcessor.new 'swf binary data'
  end

  describe 'swf_binary' do
    it 'ctor で受け取ったデータを返す' do
      swf_processor.swf_binary.should == 'swf binary data'
    end
  end

  describe 'replace_images' do
    it 'ImageSwfParameter から replace target を生成し差し替える' do
      parameters = []
      parameters.push stub(create_replace_target: 'target 1')
      parameters.push stub(create_replace_target: 'target 2')
      SwfRuby::SwfTamperer.should_receive(:replace).with(swf_processor.swf_binary, ['target 1', 'target 2'])
      swf_processor.replace_images(parameters)
    end
  end
end