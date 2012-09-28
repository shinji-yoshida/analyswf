# -*- encoding: utf-8 -*-
require 'replacement'

module Replacement
  describe JpegSwfParameter do
    describe 'encode' do
      it 'offset=12, リソース名 hoge をエンコードすると、{"swf_parameter_jpeg_12" => "hoge"} になる' do
        JpegSwfParameter.new(offset: 12, test_resource_name: 'hoge').encode.should == {"swf_parameter_jpeg_12" => "hoge"}
      end
    end

    describe 'decode' do
      it 'encode したものを復元できる' do
        encoded = JpegSwfParameter.new(offset: 12, test_resource_name: 'hoge').encode
        decoded = JpegSwfParameter.decode(encoded.first[0], encoded.first[1])
        decoded.type.should == TargetType::JPEG
        decoded.offset.should == 12
        decoded.test_resource_name.should == 'hoge'
      end
    end

    describe 'create_replace_target' do
      it '画像バイナリと offset で SwfRuby::Jpeg2ReplaceTarget を作成' do
        parameter = JpegSwfParameter.new(offset: 12, test_resource_name: 'hoge')
        parameter.stub(:image_path).and_return 'path/to/image'
        File.should_receive(:binread).with('path/to/image').and_return 'image binary'
        # exercise
        target = parameter.create_replace_target
        #verify
        target.should be_kind_of SwfRuby::Jpeg2ReplaceTarget
        target.jpeg.should == 'image binary'
        target.offset.should == 12
      end
    end
  end
end