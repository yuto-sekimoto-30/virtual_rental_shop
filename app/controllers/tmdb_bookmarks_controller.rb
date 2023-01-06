class TmdbBookmarksController < ApplicationController
  before_action :require_login
  require 'themoviedb-api'
  Tmdb::Api.key("a345acb42340ca68939f4c241dc52adb")
  Tmdb::Api.language("ja")

  def index
    if !params[:user_id].blank?
      user_id = params[:user_id]
    else
      user_id = current_user.id
    end
    user = User.find(user_id)
    @tmdb_bookmarks = user.tmdb_bookmarks
    puts @tmdb_bookmarks.count
    @movies = []
    @tmdb_bookmarks.each do |tmdb_bookmark|
      puts tmdb_bookmark.tmdb_id
      @movie = JSON.parse((Tmdb::Movie.detail(tmdb_bookmark.tmdb_id)).to_json)['table']
      @movies.push(@movie)
    end
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
end
