require 'spec_helper'

describe SwfTitlesController do
  render_views

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "returns http success with some titles" do
      FactoryGirl.create(:swf_title)
      FactoryGirl.create(:swf_title)
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "put 'create'" do
    it "returns http success" do
      put 'create', swf_title: FactoryGirl.attributes_for(:swf_title)
      response.should redirect_to swf_titles_url
    end
  end

end
