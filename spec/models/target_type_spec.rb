# -*- encoding: utf-8 -*-
require 'spec_helper'

describe TargetType do
  describe 'encode_target' do
    it '識別子とタイプを一つの文字列で表す' do
      TargetType.encode_target('target_name', TargetType::GIF).should == "target_name(gif)"
    end
  end
end