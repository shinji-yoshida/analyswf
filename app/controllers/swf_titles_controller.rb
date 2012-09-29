class SwfTitlesController < ApplicationController
  def index
    @swf_titles = SwfTitle.all
  end
end
