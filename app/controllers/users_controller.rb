class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :require_login, only: %i[index show edit update]
  before_action :user_authority, only: %i[edit update]

  def show
    render layout: "profile"
  end

  def new
    @user = User.new
  end

  def edit
    render layout: "profile"
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to users_path, success: t('.success')
    else
      flash.now[:danger] = t '.fail'
      render :new
    end
  end

  def update
    #binding.pry
    if @user.update(user_params)
      redirect_to user_path(current_user), success: t('.success')
    else
      flash.now[:danger] = t '.fail'
      render :edit
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :birth_date, :gender, :introduction, :password, :password_confirmation, :avatar, :avatar_cache)
  end

  def user_authority
    if params[:id].to_i != current_user.id
      redirect_to user_path(current_user), success: "権限がありません"
    end
  end
end
