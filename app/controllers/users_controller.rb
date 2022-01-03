class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :index]
  
  # def index
  #   users = User.all
  # end

  def show
    @user = User.find(params[:id])
    Redis.current.set('mykey', 'Hello')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url
    else
      render :new
    end
  end

  # def edit
  # end

  # def update
  # end

  # def destroy
  # end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
