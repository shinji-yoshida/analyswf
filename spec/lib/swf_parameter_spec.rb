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

  describe 'decode_params' do
    before do
      params = {}
      params.merge!(JpegSwfParameter.new(offset: 12, test_resource_name: 'hoge').encode)
      params.merge!(GifSwfParameter.new(offset: 34, test_resource_name: 'fuga').encode)
      params['ignored'] = 'ignored'
      @actuals = SwfParameter.decode_params(params)
    end

    it 'params の中の encode された JpegSwfParameter を復元できる' do
      @actuals.should be_any do |p|
        p.kind_of? JpegSwfParameter &&
        p.offset == 12 &&
        p.test_resource_name == 'hoge'
      end
    end

    it 'params の中の encode された GifSwfParameter を復元できる' do
      @actuals.should be_any do |p|
        p.kind_of? GifSwfParameter &&
        p.offset == 34 &&
        p.test_resource_name == 'fuga'
      end
    end
  end
end