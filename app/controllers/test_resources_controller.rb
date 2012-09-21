class TestResourcesController < ApplicationController
  def index
    @swf_series = SwfSeries.find(params[:swf_series_id])
    @test_resources = @swf_series.test_resources
  end

  def show
  end

  def new
    @swf_series = SwfSeries.find(params[:swf_series_id])
    @images = Image.all
  end

  def create
    swf_series = SwfSeries.find(params[:swf_series_id])
    image = Image.find(params[:image_id])
    swf_series.test_resources.create(image: image)
    redirect_to action: :index, swf_series_id: swf_series.id
  end

  def edit
  end
end
