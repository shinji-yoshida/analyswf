class SwfSeriesController < ApplicationController
  def index
    @some_series = SwfSeries.all
  end

  def show
  end

  def new
    @series = SwfSeries.new
  end
end
