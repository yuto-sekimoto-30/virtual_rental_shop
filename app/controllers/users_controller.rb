class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all.page(params[:page])
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, success: t('.success')
    else
      flash.now[:danger] = t '.fail'
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, success: t('.success')
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :avatar_cache)
  end
end
