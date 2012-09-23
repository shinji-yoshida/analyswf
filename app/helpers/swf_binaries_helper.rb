module SwfBinariesHelper
  def swf_binaries_flash_tag(url)
    content_tag :object, data: url, type: "application/x-shockwave-flash", width: 320, height: 240 do
      %Q{
        <param name="src" value="flash.swf">
        <param name="autostart" value="true">
        <param name="loop" value="false">
      }.html_safe
    end
  end
end
