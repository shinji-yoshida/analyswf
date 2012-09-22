# -*- encoding: utf-8 -*-
require 'swf_parameter'
require 'jpeg_swf_parameter'

describe SwfParameter do
  describe 'decode' do
    it 'JpegSwfParameter を encode したものを復元できる' do
      encoded = JpegSwfParameter.new(offset: 12, test_resource_name: 'hoge').encode
      decoded = SwfParameter.decode(encoded.first[0], encoded.first[1])
      decoded.should be_kind_of(JpegSwfParameter)
    end

    it 'GifSwfParameter を encode したものを復元できる' do
      encoded = GifSwfParameter.new(offset: 34, test_resource_name: 'fuga').encode
      decoded = SwfParameter.decode(encoded.first[0], encoded.first[1])
      decoded.should be_kind_of(GifSwfParameter)
    end
  end
end