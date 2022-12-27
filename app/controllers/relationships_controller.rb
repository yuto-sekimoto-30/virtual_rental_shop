class RelationshipsController < ApplicationController
  before_action :require_login, only: %i[create destroy]
  def index
    if !params[:user_id].blank?
      user_id = params[:user_id] 
    else
      user_id = current_user.id
    end
    relationships = Relationship.where(follower_id: user_id)
    @main_user = User.find(user_id)
    @users = []
    relationships.each do |relationship|
      @users.push(User.find(relationship.followed_id))
    end
  end
  
  def create
    current_user.follow(params[:followed_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(Relationship.find(params[:id]).followed_id)
    redirect_to request.referer  
  end

  private
  def bookmark_Authority
    if params[:user_id] != current_user.id
      redirect_to users_path
    end
  end
end
