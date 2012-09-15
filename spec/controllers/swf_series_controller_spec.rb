# -*- encoding: utf-8 -*-
require 'spec_helper'

describe SwfSeriesController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    let(:swf_series) {SwfSeries.create()}
    it "returns http success" do
      get 'show', id: swf_series.id
      response.should be_success
    end
  end

  describe 'collect_targets' do
    it '{"target_hoge" => "fuga"} を与えると {"hoge" => "fuga"} を返す' do
      controller.send(:collect_targets, {"target_hoge" => "fuga"}).should == {"hoge" => "fuga"}
    end
  end

end
