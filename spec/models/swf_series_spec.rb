# -*- encoding: utf-8 -*-
require 'spec_helper'

describe SwfSeries do
  describe 'put_target' do
    it 'データベースに保存される' do
      subject = SwfSeries.new
      subject.put_target('name', TargetType::GIF)
      subject.save
      actual = SwfSeries.find(subject.id).get_target('name').should == TargetType::GIF
    end
  end

  describe 'jpeg_target_names' do
    before do
      subject = SwfSeries.new
      subject.put_target('gif name 1', TargetType::GIF)
      subject.put_target('jpeg name 1', TargetType::JPEG)
      subject.put_target('jpeg name 2', TargetType::JPEG)
      @actual = subject.jpeg_target_names
    end

    it 'jpeg タイプのターゲットの名前の配列を取得する' do
      @actual.should be_include('jpeg name 1')
      @actual.should be_include('jpeg name 2')
    end

    it 'gif タイプのターゲットの名前は取得しない' do
      @actual.should_not be_include('gif name 1')
    end
  end

  describe 'gif_target_names' do
    before do
      subject = SwfSeries.new
      subject.put_target('gif name 1', TargetType::GIF)
      subject.put_target('gif name 2', TargetType::GIF)
      subject.put_target('jpeg name 2', TargetType::JPEG)
      @actual = subject.gif_target_names
    end

    it 'gif タイプのターゲットの名前の配列を取得する' do
      @actual.should be_include('gif name 1')
      @actual.should be_include('gif name 2')
    end

    it 'jpeg タイプのターゲットの名前は取得しない' do
      @actual.should_not be_include('jpeg name 1')
    end
  end

  describe 'jpeg_targets' do
    before do
      @subject = SwfSeries.new
      @subject.put_target('gif name 1', TargetType::GIF)
      @subject.put_target('jpeg name 1', TargetType::JPEG)
      @subject.put_target('jpeg name 2', TargetType::JPEG)
    end

    it 'jpeg 型のみのハッシュを返す' do
      Set.new(@subject.jpeg_targets.keys).should == Set.new(@subject.jpeg_target_names)
    end
  end

  describe 'gif_targets' do
    before do
      @subject = SwfSeries.new
      @subject.put_target('gif name 1', TargetType::GIF)
      @subject.put_target('gif name 2', TargetType::GIF)
      @subject.put_target('jpeg name 1', TargetType::JPEG)
    end

    it 'gif 型のみのハッシュを返す' do
      Set.new(@subject.gif_targets.keys).should == Set.new(@subject.gif_target_names)
    end
  end
end

# == Schema Information
#
# Table name: swf_series
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  version     :integer
#  data        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  test_script :text             default(""), not null
#
# Indexes
#
#  index_swf_series_on_name  (name)
#

