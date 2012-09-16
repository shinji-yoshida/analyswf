class SwfBinariesController < ApplicationController
  def show
    @id = params[:id]
  end

  def do_send
    swf_binary = SwfBinary.find(params[:id])
    response.headers["Content-Type"] = "application/x-shockwave-flash"
    send_data swf_binary.data, :type => "swf", :disposition => 'inline'
  end
end
