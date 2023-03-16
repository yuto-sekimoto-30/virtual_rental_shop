class RelationshipsController < ApplicationController
  before_action :require_login, only: %i[create destroy]
  before_action :set_user, only: %i[index]
  before_action :get_movie_data, only: %i[index]

  def index
    relationships = Relationship.where(follower_id: @user.id)
    @users = []
    relationships.each do |relationship|
      @users.push(User.find(relationship.followed_id))
    end
    render layout: "profile"
  end

  def create
    @followed_id = params[:followed_id]
    current_user.follow(params[:followed_id])
  end

  def destroy
    @followed_id = Relationship.find(params[:id]).followed_id
    current_user.unfollow(Relationship.find(params[:id]).followed_id)
  end

  private
  def bookmark_Authority
    if params[:user_id] != current_user.id
      redirect_to users_path
    end
  end

  def set_user
    if !params[:user_id].blank?
      user_id = params[:user_id]
    else
      user_id = current_user.id
    end
    @user = User.find(user_id)
  end
end
