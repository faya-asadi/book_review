class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create  
    @user = User.new(user_params)
    if @user.save
      flash[:noticed] = "Welcome to book review site #{@user.username}"
        redirect_to books_path
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

  end
