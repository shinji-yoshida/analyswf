# -*- encoding: utf-8 -*-
require 'spec_helper'

describe TestResourcesController do

  let(:swf_series){ FactoryGirl.create(:swf_series) }
  let(:test_resource){ FactoryGirl.create(:test_resource, swf_series: swf_series) }

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', swf_series_id: test_resource.swf_series.id
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: test_resource.id
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new', swf_series_id: FactoryGirl.create(:swf_series).id
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit', id: test_resource.id
      response.should be_success
    end
  end

  describe 'post create' do
    it 'test_resource を作成する' do
      stubbed_image = FactoryGirl.build(:image, id: 1)
      Image.should_receive(:find).with("1").and_return stubbed_image
      post 'create', image_id: 1, swf_series_id: swf_series.id
      swf_series.test_resources.find_by_image_id(1).should be_present
    end
  end

end
