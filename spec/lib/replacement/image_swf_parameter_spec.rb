# -*- encoding: utf-8 -*-
require 'replacement'

module Replacement
  describe ImageSwfParameter do
    describe 'image_path' do
      let(:image){FactoryGirl.build(:image)}

      it 'TestResouce.name == test_resource_name となるような TestResouce の画像パスを返す' do
        name = 'hoge'
        image.content.stub(:path).and_return 'path/to/image'
        Image.should_receive(:find_by_name).with(name).and_return image
        ImageSwfParameter.new(offset: 1, test_resource_name: name).image_path.should == 'path/to/image'
      end
    end

  end
end