# -*- encoding: utf-8 -*-
class SwfTitlesController < ApplicationController
  def index
    @swf_titles = SwfTitle.all
  end

  def new
    @swf_title = SwfTitle.new
  end

  def create
    @swf_title = SwfTitle.new
    @swf_title.assign_attributes(params[:swf_title])
    validate(@swf_title)
    @swf_title.save!
    redirect_to swf_titles_url
  end

  private

  def validate(swf_title)
    raise Errors::ApplicationError.new("名前を設定してください") if swf_title.name.blank?
    if swf_title.new_record?
      raise Errors::ApplicationError.new("同名の swf title が存在します") if SwfTitle.find_by_name(swf_title.name)
    end
  end
end
