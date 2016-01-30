class TagsController < ApplicationController

  def index
    @tags = Tag.all.order('name ASC')
  end

  def show
    @tag = params[:genre].capitalize
    @movies = Tag.find_by_name(params[:genre]).movies
  end

end
