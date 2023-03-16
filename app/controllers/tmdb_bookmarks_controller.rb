class TmdbBookmarksController < ApplicationController
  include TmdbKey
  before_action :require_login
  before_action :set_user, only: %i[index]
  before_action :get_movie_data, only: %i[index]

  def index
    @tmdb_bookmarks = @user.tmdb_bookmarks
    @movies = []
    @tmdb_bookmarks.each do |tmdb_bookmark|
      @movie = JSON.parse((Tmdb::Movie.detail(tmdb_bookmark.tmdb_id)).to_json)['table']
      @movies.push(@movie)
    end
    p @movies
    render layout: "profile"
  end

  def create
    TmdbBookmark.create!(user_id: current_user.id, tmdb_id: params[:tmdb_id])
    @tmdb_id = params[:tmdb_id]
  end

  def destroy
    tmdb_bookmark = TmdbBookmark.find(params[:id])
    @tmdb_id = tmdb_bookmark.tmdb_id
    tmdb_bookmark.destroy!
  end

  private
  def set_user
    if !params[:user_id].blank?
      user_id = params[:user_id]
    else
      user_id = current_user.id
    end
    @user = User.find(user_id)
  end

end
