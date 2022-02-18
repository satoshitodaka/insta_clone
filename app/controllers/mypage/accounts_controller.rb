class Mypage::AccountsController < ApplicationController
  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(account_params)
      redirect_to user_path(current_user), success: 'プロフィールを更新しました。'
   else
    flash.now[:danger] = 'プロフィールの更新に失敗しました。'
      render :edit
   end
  end

  private

    def account_params
      params.require(:user).permit(:username, :avatar, :password, :password_confirmation)
    end
end
