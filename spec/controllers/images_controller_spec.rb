require 'spec_helper'

describe ImagesController do
  let(:image) { FactoryGirl.build(:image, id: 1) }

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      Image.should_receive(:find).with(image.id.to_s).and_return image
      get 'show', id: image.id
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "DELETE 'destroy'" do
    it "returns http success" do
      delete 'destroy', id: image.id
      response.should redirect_to action: :index
    end
  end

end
