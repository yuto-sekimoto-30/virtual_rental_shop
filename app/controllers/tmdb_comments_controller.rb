class TmdbCommentsController < ApplicationController
  def create
    @tmdb_comment = current_user.tmdb_comments.new(comment_params)
    if @tmdb_comment.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
  end

  private
  def comment_params
    params.require(:tmdb_comment).permit(:tmdb_id, :comment)
  end
end
