# -*- encoding: utf-8 -*-
require 'spec_helper'

describe SwfsController do
  let(:swf_series){ FactoryGirl.create(:swf_series) }
  let(:swf){ FactoryGirl.create(:swf) }

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', swf_series_id: swf_series.id
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: swf
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new', swf_series_id: swf_series.id
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

  describe 'create_swf' do
    before do
      @swf_data = 'swf data'
      controller.stub(:analyze_swf).and_return stub(jpeg_offsets: [1, 3], gif_offsets: [2, 5])
      controller.send(:create_swf, swf_series, @swf_data)
      swf_series.reload
    end

    it 'jpeg タイプのオフセットとして 1 をもつ' do
      swf_series.swfs.first.offsets.should be_any{|o| o.offset_type == TargetType::JPEG && o.value == 1}
    end

    it 'jpeg タイプのオフセットとして 3 をもつ' do
      swf_series.swfs.first.offsets.should be_any{|o| o.offset_type == TargetType::JPEG && o.value == 3}
    end

    it 'gif タイプのオフセットとして 2 をもつ' do
      swf_series.swfs.first.offsets.should be_any{|o| o.offset_type == TargetType::GIF && o.value == 2}
    end

    it 'jpeg タイプのオフセットとして 5 をもつ' do
      swf_series.swfs.first.offsets.should be_any{|o| o.offset_type == TargetType::GIF && o.value == 5}
    end

    it 'swf_binary を生成する' do
      swf_series.swfs.first.swf_binary.data.should == @swf_data
    end
  end

  describe 'analyze_swf' do
    it '例外発生時には一時ファイルを削除する' do
      controller.stub(:do_analyze_swf).and_throw('exception')
      controller.should_receive(:delete_tmp_swf_file)
      expect{ controller.send(:analyze_swf, 'data')}.to raise_error
    end
  end

end
