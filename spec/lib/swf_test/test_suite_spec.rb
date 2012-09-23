# -*- encoding: utf-8 -*-
require 'swf_test/test_suite'

describe SwfTest::TestSuite do
  describe 'replace' do
    let(:test_cases) do
      [create_test_case(), create_test_case()]
    end
    let(:test_suite){SwfTest::TestSuite.new(test_cases)}

    it 'index 0 の test_case を実行できる' do
      swf = 'swf binary'
      expected = 'expected swf'
      test_cases[0].should_receive(:replace).with(swf).and_return expected
      # exercise
      test_suite.replace(0, swf).should == expected
    end
  end

  it 'size は test_cases の要素数を返す' do
    test_suite = SwfTest::TestSuite.new(['stub', 'stub', 'stub'])
    test_suite.size.should == 3
  end

  describe 'description' do
    it 'index 1 の description を取得できる' do
      expected = 'hoge'
      test_suite = SwfTest::TestSuite.new [create_test_case(), SwfTest::TestCase.new(expected, [])]
      test_suite.description(1).should == expected
    end
  end
end

def create_test_case
  SwfTest::TestCase.new('testing', [])
end