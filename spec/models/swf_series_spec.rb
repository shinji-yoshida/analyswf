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
end

# == Schema Information
#
# Table name: swf_series
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  version    :integer
#  data       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

