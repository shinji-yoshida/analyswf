require 'spec_helper'

describe SwfTitlesController do

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

end
