# -*- encoding: utf-8 -*-
require 'replacement'

module Replacement
  describe GifSwfParameter do
    describe 'encode' do
      it 'offset=12, リソース名 hoge をエンコードすると、{"swf_parameter_gif_12" => "hoge"} になる' do
        GifSwfParameter.new(offset: 12, test_resource_name: 'hoge').encode.should == {"swf_parameter_gif_12" => "hoge"}
      end
    end

    describe 'decode' do
      it 'encode したものを復元できる' do
        encoded = GifSwfParameter.new(offset: 12, test_resource_name: 'hoge').encode
        decoded = GifSwfParameter.decode(encoded.first[0], encoded.first[1])
        decoded.type.should == TargetType::GIF
        decoded.offset.should == 12
        decoded.test_resource_name.should == 'hoge'
      end
    end

    describe 'create_replace_target' do
      it '画像バイナリと offset で SwfRuby::Lossless2ReplaceTarget を作成' do
        parameter = GifSwfParameter.new(offset: 12, test_resource_name: 'hoge')
        parameter.stub(:image_path).and_return 'path/to/image'
        File.should_receive(:binread).with('path/to/image').and_return 'image_binary'
        SwfRuby::Lossless2ReplaceTarget.should_receive(:new).with(12, 'image_binary').and_return 'result'
        # exercise
        parameter.create_replace_target.should == 'result'
      end
    end
  end
end