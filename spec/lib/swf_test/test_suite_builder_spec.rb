# -*- encoding: utf-8 -*-
require 'swf_test/test_suite_builder'

describe SwfTest::TestSuiteBuilder do
  let(:context){SwfTest::Context.new(nil)}
  let(:subject){SwfTest::TestSuiteBuilder.new(context)}

  describe 'to_test' do
    it 'test case を作成する' do
      context.stub(:offset).and_return 3
      subject.to_test 'description' do
        replace_jpeg 'target', with: 'img'
        check 'check 1'
      end
      subject.get_test_cases.size.should == 1
      subject.get_test_cases[0].description.should == 'description'
      subject.get_test_cases[0].check_items.should == ['check 1']
    end

    it '複数の test case を作成できる' do
      context.stub(:offset).and_return 3
      subject.to_test 'description 1' do
        replace_jpeg 'target 1', with: 'img 1'
        check 'check 1'
      end
      subject.to_test 'description 2' do
        replace_jpeg 'target 2', with: 'img 2'
        check 'check 2'
      end
      subject.get_test_cases.size.should == 2
    end
  end

  describe 'eval_script' do
    it 'スクリプトを評価し test suite を作成する' do
      context.stub(:offset).and_return 3
      suite = subject.eval_script %Q{
        to_test 'description 1' do
          replace_jpeg 'target 1', with: 'img 1'
        end

        to_test 'description 2' do
          check 'check 2'
        end
      }
      suite.size.should == 2
      suite.description(0).should == 'description 1'
      suite.description(1).should == 'description 2'
    end
  end
end