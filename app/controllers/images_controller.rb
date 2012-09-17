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
    image = Image.create!(params[:image])
    redirect_to action: :show, id: image.id
  end

  def destroy
    redirect_to action: :index
  end
end
