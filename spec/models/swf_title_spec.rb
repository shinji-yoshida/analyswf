# -*- encoding: utf-8 -*-
require 'spec_helper'

describe SwfTitle do
  let(:subject){FactoryGirl.create(:swf_title)}
  describe 'latest_swf_series' do
    it 'version が新しいものを返す' do
      FactoryGirl.create(:swf_series, swf_title_id: subject.id, version: 1)
      FactoryGirl.create(:swf_series, swf_title_id: subject.id, version: 3)
      FactoryGirl.create(:swf_series, swf_title_id: subject.id, version: 2)
      actual = subject.reload.latest_swf_series
      actual.should be_present
      actual.version.should == 3
    end

    it '存在しない場合 nil' do
      subject.latest_swf_series.should be_nil
    end
  end
end

# == Schema Information
#
# Table name: swf_titles
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  latest_swf_series_id :integer
#  latest_swf_id        :integer
#

