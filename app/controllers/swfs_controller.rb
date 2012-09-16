# -*- encoding: utf-8 -*-
require 'fileutils'
require 'swf_analyzer'

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
    Swf.transaction do
      @swf = create_swf(swf_series, params[:file].read)
    end
    redirect_to action: :show, id: @swf.id
  end

  private

  def create_swf(swf_series, swf_data)
    swf = swf_series.swfs.create!
    analyzed = analyze_swf(swf_data)
    analyzed.jpeg_offsets.each do |o|
      swf.offsets.create!(offset_type: TargetType::JPEG, value: o)
    end
    analyzed.gif_offsets.each do |o|
      swf.offsets.create!(offset_type: TargetType::GIF, value: o)
    end
    swf.create_swf_binary!(data: swf_data)
    return swf
  end

  def tmp_swf_dir
    result = Rails.root.join('tmp', 'swf')
    FileUtils.mkdir_p result
    return result
  end

  def tmp_swf_file
    tmp_swf_file = File.join(tmp_swf_dir, 'tmp.swf')
  end

  def analyze_swf(data)
    do_analyze_swf(data)
  rescue => e
    delete_tmp_swf_file
    raise ApplicationException.new "例外: #{e.message}"
  end

  def do_analyze_swf(data)
    File.binwrite(tmp_swf_file, data)
    result = SwfAnalyzer.analyze_swf(tmp_swf_file)
    delete_tmp_swf_file
    return result
  end

  def delete_tmp_swf_file
    File.delete(tmp_swf_file)
  end
end
