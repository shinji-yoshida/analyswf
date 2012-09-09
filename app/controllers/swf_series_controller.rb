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

  def create
    @series = SwfSeries.new(params[:swf_series])
    targets = {}
    p params
    params.each do |key, value|
      unless key.match(/^target_/)
        next
      end
      targets[key] = value
    end
    targets.each do |key, type|
      @series.put_target(key.sub(/^target_/, ''), type)
    end

    if @series.save
      redirect_to @series, notice: 'Post was successfully created.'
    else
      render action: "new"
    end
  end
end
