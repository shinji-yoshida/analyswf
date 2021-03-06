# -*- encoding: utf-8 -*-
require 'spec_helper'

describe SwfsController do
  let(:swf_series){ FactoryGirl.create(:swf_series) }
  let(:swf){ FactoryGirl.create(:swf) }

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', swf_series_id: swf_series.id
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: swf
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new', swf_series_id: swf_series.id
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit', id: swf.id
      response.should be_success
    end
  end
end
