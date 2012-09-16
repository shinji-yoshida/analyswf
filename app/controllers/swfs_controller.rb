class SwfsController < ApplicationController
  def index
    @swf_series = SwfSeries.find(params[:swf_series_id])
    @swfs = @swf_series.swfs.all
  end

  def show
    @swf = Swf.find(params[:id])
    @swf_series = @swf.swf_series
  end

  def new
    @swf_series = SwfSeries.find(params[:swf_series_id])
  end

  def edit
  end

  def create
    swf_series = SwfSeries.find(params[:swf_series_id])
    f = params[:file]
    Swf.transaction do
      @swf = swf_series.swfs.create!
      @swf.create_swf_binary!(data: f.read)
    end
    redirect_to action: :show, id: @swf.id
  end
end
