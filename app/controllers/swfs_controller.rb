class SwfsController < ApplicationController
  def index
    swf_series = SwfSeries.find(params[:swf_series_id])
    @swfs = swf_series.swfs.all
  end

  def show
  end

  def new
    @swf_series = SwfSeries.find(params[:swf_series_id])
  end

  def edit
  end
end
