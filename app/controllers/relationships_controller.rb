class RelationshipsController < ApplicationController

  def follow
    current_user.follow(params[:id])
    redirect_to request.referer
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_to request.referer
  end

  def follower
    @user=User.find(params[:id])
    # @users=@user.follower
  end

  def followed
    @user=User.find(params[:id])
    # @users=@user.followed
  end


end
