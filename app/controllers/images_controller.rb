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
    image = Image.new
    image.assign_attributes(params[:image])
    validate(image)
    image.save!
    redirect_to action: :show, id: image.id
  end

  def destroy
    redirect_to action: :index
  end

  private

  def validate(image)
    if image.new_record?
      raise Errors::ApplicationError.new "#{image.name} という名前はすでに存在します" if Image.find_by_name(image.name).present?
    end

    raise Errors::ApplicationError.new "画像が指定されていません" if image.content_file_size.blank?
  end
end
