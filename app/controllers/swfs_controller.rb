# -*- encoding: utf-8 -*-
require 'fileutils'
require 'hash_extension'
require 'swf_analyzer'
require 'replacement'

class SwfsController < ApplicationController
  def index
    @swf_series = SwfSeries.find(params[:swf_series_id])
    @swfs = @swf_series.swfs.all
  end

  def show
    @swf = Swf.find(params[:id])
    @swf_series = @swf.swf_series
    image_target_names = @swf_series.jpeg_target_names + @swf_series.gif_target_names
    @target_name_to_offset_map = create_target_name_to_offset_map(image_target_names, @swf.offsets)
  end

  def new
    @swf_series = SwfSeries.find(params[:swf_series_id])
  end

  def edit
    @swf = Swf.find(params[:id])
    @test_resources = @swf.swf_series.test_resources.all
  end

  def create
    swf_series = SwfSeries.find(params[:swf_series_id])
    Swf.transaction do
      @swf = create_swf(swf_series, params[:file].read)
    end
    redirect_to action: :show, id: @swf.id
  end

  def update
    swf = Swf.find(params[:id])
    new_offsets = decode_prefixed(params, 'offset_')
    Swf.transaction do
      swf.offsets.each do |o|
        o.target_name = new_offsets[o.value.to_s] # could be nil
        o.save!
      end
    end
    redirect_to swf_url(id: swf.id)
  end

  def test
    @swf = Swf.find(params[:id])
    @target_name = params[:target_name]
    @offset = @swf.offsets.find{|o| o.target_name == @target_name}
    @typed_test_resouces = @swf.swf_series.test_resources.select{|r| r.image_type == @offset.offset_type}
  end

  private

  def create_target_name_to_offset_map(target_names, offsets)
    target_names.inject({}) do |result, name|
      offset = offsets.find{|o| o.target_name == name}
      result[name] = offset if offset.present?
      result
    end
  end

  def decode_prefixed(params, prefix)
    params.select{|k, v| /^#{prefix}/ =~ k}.extend(HashExtension).convert_keys{|k| k.sub(/^#{prefix}/, '')}
  end

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
