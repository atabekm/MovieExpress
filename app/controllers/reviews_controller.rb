class ReviewsController < ApplicationController

  def create
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.create(review_params)
    send_post("[Review][Create] '#{@review.body}' for '#{@movie}'")
    redirect_to movie_path(@movie)
  end

  private
  def review_params
    params.require(:review).permit(:body, :user_id, :star)
  end

end
