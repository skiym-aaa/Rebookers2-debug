class RelationshipsController < ApplicationController
  def create
    current_user.follow(params[:user_id])
    # current_user.follow(params[:user_id])とすることで
    # 「follower_id: current_user.id」を代入しながらインスタンスを作成
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def follower
    user = User.find(params[:user_id])
    @users = user.following_user
  end

  def followed
    user = User.find(params[:user_id])
    @users = user.follower_user
  end
end
