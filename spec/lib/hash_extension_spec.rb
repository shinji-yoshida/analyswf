# -*- encoding: utf-8 -*-
require 'hash_extension'

describe HashExtension do
  before do
    @subject = {}
    @subject.extend HashExtension
  end

  describe 'convert_keys' do
    it 'key を変換する' do
      @subject['hoge'] = 'h'
      @subject['fuga'] = 'f'
      # exercise
      actual = @subject.convert_keys{|k| k + k}
      actual['hoge'].should be_blank
      actual['fuga'].should be_blank
      actual['hogehoge'].should == 'h'
      actual['fugafuga'].should == 'f'
    end
  end

end