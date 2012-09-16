# -*- encoding: utf-8 -*-
require 'swf_analyzer'

describe SwfAnalyzer do
  describe 'analyze' do
    before do
      dump_text = <<'EOS'
PlaceObject2, offset: 109, refer_character_id: 2, length: 11
DefineBitsLossless2, offset: 120, character_id: 3, length: 178
DefineShape, offset: 298, character_id: 4, bitmap_id: 65535(offset: 16), bitmap_id: 3(offset: 26), length: 55
DefineBitsJPEG2, offset: 623, character_id: 6, length: 10986
DefineBitsLossless2, offset: 1200, character_id: 3, length: 178
DefineBitsJPEG2, offset: 6230, character_id: 6, length: 10986
EOS
      @subject = SwfAnalyzer.analyze_dump(dump_text)
    end

    it 'jpeg オフセットは 623, 6230' do
      @subject.jpeg_offsets.should == [623, 6230]
    end

    it 'gif オフセットは 120, 1200' do
      @subject.gif_offsets.should == [120, 1200]
    end
  end
end