module SwfSeriesHelper
  def swf_series_targets_options(series)
    series.targets.map{|key, value| TargetType.encode_target(key, value)}
  end

  def swf_series_name_link(series)
    link_to series.name, series
  end
end
