# -*- encoding: utf-8 -*-
require 'image_swf_parameter'

describe ImageSwfParameter do
  describe 'image_path' do
    let(:image){FactoryGirl.build(:image)}
    let(:test_resource){FactoryGirl.build(:test_resource, image: image)}

    it 'TestResouce.name == test_resource_name となるような TestResouce の画像パスを返す' do
      name = 'hoge'
      image.content.stub(:path).and_return 'path/to/image'
      TestResource.should_receive(:find_by_name).with(name).and_return test_resource
      ImageSwfParameter.new(offset: 1, test_resource_name: name).image_path.should == 'path/to/image'
    end
  end

end