class MoviesController < ApplicationController
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

    @total
  end

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to @movie, notice: 'The movie was successfully created'
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: 'The movie was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy

    redirect_to movies_path
  end

  def search
    @query = params[:search]
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
