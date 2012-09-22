# -*- encoding: utf-8 -*-
require 'gif_swf_parameter'

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
      decoded.offset == 12
      decoded.test_resource_name == 'hoge'
    end
  end
end