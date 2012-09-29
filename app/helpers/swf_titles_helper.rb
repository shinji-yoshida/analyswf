module SwfTitlesHelper
  def swf_titles_latest_swf_series_version(swf_title)
    latest_swf_series = swf_title.latest_swf_series
    latest_swf_series.present? ? "#{latest_swf_series.version}" : "-"
  end
end
