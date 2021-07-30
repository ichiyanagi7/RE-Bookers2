class UsersController < ApplicationController
  
  def index
    @users=User.all
    @user=current_user
    @booknew=Book.new
  end
  
  def show
    @user=User.find(params[:id])
    @books=@user.books
    @booknew=Book.new
  end
  
end
