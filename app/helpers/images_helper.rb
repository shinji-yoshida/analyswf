module ImagesHelper
  def image_name_link(image)
    link_to image.name, image_url(image)
  end
end
