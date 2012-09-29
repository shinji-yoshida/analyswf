# -*- encoding: utf-8 -*-
require 'replacement'
require 'swf_test/test_suite_builder'

class SwfSeriesController < ApplicationController
  before_filter :load_swf_title, only: [:index, :new]

  def index
    @some_series = @swf_title.swf_series.all
  end

  def show
    @series = SwfSeries.find(params[:id])
  end

  def new
    @series = @swf_title.swf_series.build
  end

  def create
    @series = SwfSeries.new(params[:swf_series])

    set_swf_series_targets(@series, collect_targets(params))

    swf_title = @series.swf_title
    swf_title.with_lock do
      @series.version = get_latest_version(swf_title) + 1
      @series.save!
      swf_title.latest_swf_series = @series
      swf_title.save!
    end

    redirect_to @series
  rescue => e
    flash[:alert] = e.message
    render action: "new"
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

  def load_swf_title
    @swf_title = SwfTitle.find(params[:swf_title_id])
  end

  def set_swf_series_targets(swf_series, targets)
    targets.each do |key, type|
      swf_series.put_target(key, type)
    end
  end

  def get_latest_version(swf_title)
    latest_swf_series = swf_title.latest_swf_series
    if latest_swf_series.present?
      return latest_swf_series.version
    else
      return 0
    end
  end

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
