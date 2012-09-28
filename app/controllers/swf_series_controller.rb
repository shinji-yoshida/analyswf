# -*- encoding: utf-8 -*-
require 'replacement'
require 'swf_test/test_suite_builder'

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

  def edit
    @swf_series = SwfSeries.find(params[:id])
    @swf_series.test_script = example_script if @swf_series.test_script.blank?
  end

  def update
    swf_series = SwfSeries.find(params[:id])
    test_script = params[:swf_series][:test_script]
    begin
      SwfTest::TestSuiteBuilder.new(ContextStub.new).eval_script(test_script)
    rescue
      raise
    end
    swf_series.test_script = test_script
    swf_series.save!
    redirect_to swf_series_url(swf_series.id)
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

  def example_script
    <<EOS
# example...
#
# to_test 'ユニット画像の差し替え' do
#   replace_jpeg 'card', with: 'sample_full_gacha'
#   check 'ユニット画像が刺し変わっている'
# end
#
# to_test 'モンスター画像の差し替え' do
#   replace_gif 'monster', with: 'sample_mon_battle'
#   check 'モンスター画像が差し替わっている'
#   check '画像の透過処理が正しく行われている'
# end
EOS
  end

  class ContextStub
    def offset(target)
      return 0
    end
  end
end
