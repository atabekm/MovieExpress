class TagsController < ApplicationController

  def index
    send_post("[Genre][Show] All")
    @tags = Tag.all.order('name ASC')
  end

  def show
    @tag = params[:genre].capitalize
    send_post("[Genre][Show] '#{@tag}'")
    @movies = Tag.find_by_name(params[:genre]).movies
  end

end
