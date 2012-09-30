# -*- encoding: utf-8 -*-
require 'spec_helper'

module Domain
  describe Swf do
    describe 'setup!' do
      let(:swf){FactoryGirl.create(:swf)}
      before do
        swf.extend(Domain::Swf)
        swf.stub(:setup_offsets!)
      end

      it 'setup_offsets! を呼び出す' do
        swf.should_receive(:setup_offsets!).with('swf data stub')
        swf.setup!('swf data stub')
      end

      it 'swf_binary を生成する' do
        swf.setup!('swf data stub')
        swf.swf_binary.should be_present
        swf.swf_binary.data.should == 'swf data stub'
      end
    end

    describe 'setup_offsets!' do
      let(:swf){FactoryGirl.create(:swf)}
      before do
        swf.extend(Domain::Swf)
        swf.stub(:analyze_swf).and_return Replacement::SwfAnalyzerStub.new(jpeg_offsets: [1, 2], gif_offsets: [3, 4])
        swf.send(:setup_offsets!, 'swf data stub')
      end

      it 'jpeg 型の offset を生成する' do
        swf.jpeg_offsets.should be_any{|o| o.value == 1}
        swf.jpeg_offsets.should be_any{|o| o.value == 2}
      end

      it 'gif 型の offset を生成する' do
        swf.gif_offsets.should be_any{|o| o.value == 3}
        swf.gif_offsets.should be_any{|o| o.value == 4}
      end
    end

    describe 'analyze_swf' do
      let(:swf){FactoryGirl.create(:swf)}
      before do
        swf.extend(Domain::Swf)
      end

      it '例外発生時には一時ファイルを削除する' do
        swf.stub(:do_analyze_swf).and_throw('exception')
        swf.should_receive(:delete_tmp_swf_file)
        expect{ swf.send(:analyze_swf, 'data')}.to raise_error
      end
    end
  end
end

module Replacement
  class SwfAnalyzerStub < SwfAnalyzer
    def initialize(map)
      super(map)
    end
  end
end