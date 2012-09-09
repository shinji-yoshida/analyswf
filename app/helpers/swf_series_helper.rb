module SwfSeriesHelper
  def swf_series_targets_options(series)
    series.targets.map{|key, value| "#{key}(#{value})"}
  end
end
