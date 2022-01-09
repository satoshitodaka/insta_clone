class UserSessionsController < ApplicationController
  def new;end

  def create
    @user = login(params[:email], params[:password])

    if @user
      flash.now[:success] = 'ログインしました'
      redirect_back_or_to root_path
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, success: 'ログアウトしました'
  end
end
