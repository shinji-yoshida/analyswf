# -*- encoding: utf-8 -*-
require 'swf_test/test_case'

describe SwfTest::TestCase do
  describe 'replace' do
    let(:swf_parameters) {[]}
    let(:test_case) {SwfTest::TestCase.new('testing', swf_parameters)}

    it '与えられた swf_parameters を用いて swf の差し替えを行う' do
      expected = 'expected swf'
      Replacement::SwfProcessor.any_instance.should_receive(:replace).with(swf_parameters).and_return expected
      test_case.replace('swf binary').should == expected
    end
  end

  describe 'check_items' do
    it '複数のチェック項目を返す' do
      subject = SwfTest::TestCase.new('testing', [], ['check1', 'check2'])
      subject.check_items.should == ['check1', 'check2']
    end
  end
end