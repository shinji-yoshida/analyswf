class SwfSeriesController < ApplicationController
  def index
    @some_series = SwfSeries.all
  end

  def show
  end

  def new
    @series = SwfSeries.new
  end

  def edit
    @series = SwfSeries.find(params[:id])
  end
end
