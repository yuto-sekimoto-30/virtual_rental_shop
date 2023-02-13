class UserSessionsController < ApplicationController
  before_action :require_login, only: %i[destroy]
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to user_path(@user), success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path, success: t('.success')
  end
end
