class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  before_action :set_user

  def update
    if @user.update(user_params)
      flash[:success] = 'User was successfully updated'
      redirect_to user_path
    else
      render :edit
    end
  end

  private

  def set_user
    @user ||= User.find_by_id(params[:id])
  end

  def user_params
    params.require(:user).permit(:login, :birthday, :avatar, :avatar_cache, :facebook_id, :role, :email)
  end
end

