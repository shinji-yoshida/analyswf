# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Swf do
  describe 'jpeg_offsets' do
    before do
      subject = FactoryGirl.build(:swf)
      subject.offsets.build(FactoryGirl.attributes_for(:jpeg_offset, value: 3))
      subject.offsets.build(FactoryGirl.attributes_for(:jpeg_offset, value: 5))
      subject.offsets.build(FactoryGirl.attributes_for(:gif_offset, value: 7))
      @actual = subject.jpeg_offsets
    end

    it 'JPEG タイプのオフセットを返す' do
      @actual.should be_any{|offset| offset.offset_type == TargetType::JPEG && offset.value == 3}
      @actual.should be_any{|offset| offset.offset_type == TargetType::JPEG && offset.value == 5}
    end

    it 'GIF タイプのオフセットは返さない' do
      @actual.should_not be_any{|offset| offset.offset_type == TargetType::GIF}
    end
  end

  describe 'gif_offsets' do
    before do
      subject = FactoryGirl.build(:swf)
      subject.offsets.build(FactoryGirl.attributes_for(:jpeg_offset, value: 3))
      subject.offsets.build(FactoryGirl.attributes_for(:jpeg_offset, value: 5))
      subject.offsets.build(FactoryGirl.attributes_for(:gif_offset, value: 7))
      subject.offsets.build(FactoryGirl.attributes_for(:gif_offset, value: 9))
      @actual = subject.gif_offsets
    end

    it 'GIF タイプのオフセットを返す' do
      @actual.should be_any{|offset| offset.offset_type == TargetType::GIF && offset.value == 7}
      @actual.should be_any{|offset| offset.offset_type == TargetType::GIF && offset.value == 9}
    end

    it 'JPEG タイプのオフセットは返さない' do
      @actual.should_not be_any{|offset| offset.offset_type == TargetType::JPEG}
    end
  end
end

# == Schema Information
#
# Table name: swfs
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  swf_series_id :integer
#  version       :integer          default(0), not null
#

