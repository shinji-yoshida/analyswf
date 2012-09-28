require 'spec_helper'

describe SwfTestsController do
  let(:swf){FactoryGirl.create(:swf)}

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', swf_id: swf.id, id: 0
      response.should be_success
    end
  end

  describe "GET 'send_show'" do
    it "returns http success" do
      controller.stub(:load_test_suite) do
        controller.instance_variable_set(:@test_suite, stub(replace: 'stub'))
      end
      get 'send_show', swf_id: swf.id, id: 0
      response.should be_success
    end
  end

end
