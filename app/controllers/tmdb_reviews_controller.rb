class TmdbReviewsController < ApplicationController
  include TmdbKey
  layout "profile"
  before_action :set_tmdb_review, only: %i[new show edit update destroy]
  before_action :get_movie, only: %i[new edit create update]
  before_action :set_user, only: %i[new edit create update destroy]
  before_action :get_movie_data, only: %i[new edit create update]

  def new
    if @tmdb_review.present?
      redirect_to edit_movie_tmdb_reviews_path
    else
      @tmdb_review = TmdbReview.new
    end
  end

  def create
    @tmdb_review = TmdbReview.new(review_params)
    if @tmdb_review.save
      redirect_to edit_movie_tmdb_reviews_path, success: t('.success')
    else
      flash.now[:danger] = t '.fail'
      render :new
    end
  end

  def edit; end

  def update
    if @tmdb_review.update(review_params)
      redirect_to edit_movie_tmdb_reviews_path, success: t('.success')
    else
      flash.now[:danger] = t '.fail'
      render :edit
    end
  end

  def destroy
    @tmdb_review.destroy
    redirect_to user_path(@user), success: t('.success')
  end

  private
  def set_user
    @user = current_user
  end

  def set_tmdb_review
    @tmdb_review = current_user.tmdb_reviews.find_by(tmdb_id: params[:movie_id])
  end

  def review_params
    params.require(:tmdb_review).permit(:title, :comment, :movie_state_name_id).merge(user_id: current_user.id, tmdb_id: params[:movie_id])
  end

  def get_movie
    @movie = JSON.parse((Tmdb::Movie.detail(params[:movie_id])).to_json)['table']
    if @movie['poster_path'].blank?
      @movie['poster_path'] = "/images/no_phone.jpg"
    else
      @movie['poster_path'] = 'https://image.tmdb.org/t/p/w1280' + @movie['poster_path']
    end
    @movie['backdrop_path'] = 'https://image.tmdb.org/t/p/w1280' + @movie['backdrop_path'] if !@movie['backdrop_path'].blank?
    @movie['overview'] = "詳細不明" if @movie['overview'].blank?
    @tmdb_comments = TmdbComment.where(tmdb_id: @movie['id'])
  end
end
