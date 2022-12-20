class TmdbBookmarksController < ApplicationController
  before_action :require_login
  
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
