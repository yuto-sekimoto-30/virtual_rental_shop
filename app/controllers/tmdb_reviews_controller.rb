class TmdbReviewsController < ApplicationController
  layout "profile"
  before_action :set_tmdb_review, only: %i[show edit update destroy]

  def new
    @tmdb_review = TmdbReview.new
  end

  def create
    @tmdb_review = TmdbReview.new(review_params)
    if @tmdb_review.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def edit; end

  def update
    if @tmdb_review.update(review_params)
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    @tmdb_review.destroy
    redirect_to root_path
  end

  private
  def set_tmdb_review
    @tmdb_review = current_user.tmdb_reviews.find_by(tmdb_id: params[:movie_id])
  end

  def review_params
    params.require(:tmdb_review).permit(:title, :comment, :movie_state_name_id).merge(user_id: current_user.id, tmdb_id: params[:movie_id])
  end
end
