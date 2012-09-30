# -*- encoding: utf-8 -*-
require 'fileutils'
require 'hash_extension'
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
    @swf = Domain::Swf.create_in_transaction(swf_series, params[:file].read)
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
end
