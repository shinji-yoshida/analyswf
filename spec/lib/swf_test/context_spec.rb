# -*- encoding: utf-8 -*-
require 'swf_test/context'

describe SwfTest::Context do
  describe 'offset' do
    let(:swf){FactoryGirl.build(:swf)}
    let(:subject){SwfTest::Context.new(swf)}

    before do
      swf.offsets.build(target_name: 'hoge', offset_type: TargetType::JPEG, value: 123)
    end

    it 'offset を取得できる' do
      subject.offset('hoge').should == 123
    end

    it 'target がない場合例外発生' do
      expect{subject.offset('invalid')}.to raise_error(SwfTest::TargetNotFoundError)
    end
  end
end