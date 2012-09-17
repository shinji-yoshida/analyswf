require 'spec_helper'

describe SwfBinariesController do

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: 1
      response.should be_success
    end
  end

end
