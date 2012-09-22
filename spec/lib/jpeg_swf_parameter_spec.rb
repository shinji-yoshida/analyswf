# -*- encoding: utf-8 -*-
require 'jpeg_swf_parameter'

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
      decoded.offset == 12
      decoded.test_resource_name == 'hoge'
    end
  end
end