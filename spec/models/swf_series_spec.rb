# -*- encoding: utf-8 -*-
require 'spec_helper'

describe SwfSeries do
  describe 'put_target' do
    it 'データベースに保存される' do
      subject = SwfSeries.new
      subject.put_target('name', SwfSeries::TargetType::GIF)
      subject.save
      actual = SwfSeries.find(subject.id).get_target('name').should == SwfSeries::TargetType::GIF
    end
  end
end
