module SwfTitlesHelper
  def swf_titles_latest_swf_series_version(swf_title)
    latest_swf_series = swf_title.latest_swf_series
    latest_swf_series.present? ? "#{latest_swf_series.version}" : "-"
  end

  def swf_titles_latest_swf_series_version_link(swf_title)
    latest_swf_series = swf_title.latest_swf_series
    if latest_swf_series.present?
      link_to "#{latest_swf_series.version}", swf_series_url(latest_swf_series)
    else
      "-"
    end
  end
end
