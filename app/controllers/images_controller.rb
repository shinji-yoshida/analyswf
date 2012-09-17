# -*- encoding: utf-8 -*-
class ImagesController < ApplicationController
  def index
    @images = Image.all
  end

  def show
    @image = Image.find(params[:id])
  end

  def new
    @image = Image.new
  end

  def create
    file = params[:file]
    data = file.read
    raise ApplicationException.new 'ファイルが空です' if data.blank?
  end

  def delete
  end
end
