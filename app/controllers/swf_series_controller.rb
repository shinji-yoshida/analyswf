class SwfSeriesController < ApplicationController
  def index
    @some_series = SwfSeries.all
  end

  def show
    @series = SwfSeries.find(params[:id])
  end

  def new
    @series = SwfSeries.new
  end

  def create
    @series = SwfSeries.new(params[:swf_series])

    collect_targets(params).each do |key, type|
      @series.put_target(key, type)
    end

    if @series.save
      redirect_to @series
    else
      render action: "new"
    end
  end

  private

  def collect_targets(params)
    targets = {}
    params.each do |key, value|
      unless key.match(/^target_/)
        next
      end
      targets[key.sub(/^target_/, '')] = value
    end
    return targets
  end
end
