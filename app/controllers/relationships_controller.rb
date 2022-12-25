class RelationshipsController < ApplicationController
  def index
    relationships = Relationship.where(follower_id: current_user.id)
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
end
