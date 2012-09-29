# -*- encoding: utf-8 -*-
require 'spec_helper'

describe SwfSeriesController do
  render_views

  let(:swf_title) {FactoryGirl.create(:swf_title)}
  let(:swf_series) {FactoryGirl.create(:swf_series, swf_title: swf_title)}

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', swf_title_id: swf_series.swf_title.id
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: swf_series.id
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new', swf_title_id: swf_title.id
      response.should be_success
    end
  end

  describe "put 'create'" do

    it "新しく swf_series を作成" do
      swf_series = swf_title.swf_series.build
      expect {
        put 'create', swf_series: swf_series.attributes
        }.to change{swf_title.swf_series.count}.by 1
    end
  end

  describe 'collect_targets' do
    it '{"target_hoge" => "fuga"} を与えると {"hoge" => "fuga"} を返す' do
      controller.send(:collect_targets, {"target_hoge" => "fuga"}).should == {"hoge" => "fuga"}
    end
  end

end
