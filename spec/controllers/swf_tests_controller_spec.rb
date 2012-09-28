require 'spec_helper'

describe SwfTestsController do

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', swf_id: 0, id: 0
      response.should be_success
    end
  end

  describe "GET 'send_show'" do
    it "returns http success" do
      get 'send_show', swf_id: 0, id: 0
      response.should be_success
    end
  end

end
