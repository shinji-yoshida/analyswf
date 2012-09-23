require 'swf_parameter'
require 'swf_processor'

class SwfBinariesController < ApplicationController
  def show
    @id = params[:id]
  end

  def do_send
    swf_binary = SwfBinary.find(params[:id])
    response.headers["Content-Type"] = "application/x-shockwave-flash"
    send_data swf_binary.data, :type => "swf", :disposition => 'inline'
  end

  def show_replaced
    @swf_binary = SwfBinary.find(params[:id])
    @offset = Offset.find(params[:offset_id])
    @swf_parameter = ImageSwfParameter.create(type: @offset.offset_type, offset: @offset.value, test_resource_name: params[:resource_name])
  end

  def send_replaced
    swf_binary = SwfBinary.find(params[:id])
    swf_parameters = SwfParameter.decode_params(params)
    processor = SwfProcessor.new swf_binary.data
    response.headers["Content-Type"] = "application/x-shockwave-flash"
    send_data processor.replace(swf_parameters), :type => "swf", :disposition => 'inline'
  end
end
