require "uri"
require "net/http"

class MoviesController < ApplicationController
  $url = Rails.configuration.x.server['api_endpoint']
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index, :search]

  def show
    total = 0
    @movie.reviews.each do |r|
      total += r.star
    end

    if @movie.reviews.count > 0
      @total = total.to_f / @movie.reviews.count
    else
      @total = 0
    end

    send_post("[Movie][Show] '#{@movie}'")
    @total
  end

  def index
    send_post("[Movie][Show] All")
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      send_post("[Movie][Create] '#{@movie}'")
      redirect_to @movie, notice: 'The movie was successfully created'
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @movie.update(movie_params)
      send_post("[Movie][Update] '#{@movie}'")
      redirect_to @movie, notice: 'The movie was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    send_post("[Movie][Delete] '#{@movie}'")
    redirect_to movies_path
  end

  def search
    @query = params[:search]
    send_post("[Movie][Search] '#{@query}'")
    @movies = Movie.search(@query)
  end

  private
  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :director, :actors, :genre, :runtime, :budget, :cover, :tags_list)
  end
end
