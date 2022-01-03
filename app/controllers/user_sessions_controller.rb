class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
  def new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to root_url, notice: 'ログインしました'
    else
      flash.now[:alert] = 'ログインに失敗しました'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_url, notice: 'ログアウトしました'
  end
end
