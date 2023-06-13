class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @follower_count = current_user.followers.count
    @following_count = current_user.followings.count

    authorize @user
  end

  def edit
    authorize @user #line must be at the end of the method WARNING
  end
end
