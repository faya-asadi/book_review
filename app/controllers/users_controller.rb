class UsersController < ApplicationController
#  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_user, except: [:show, :index, :new]
  before_action :require_same_user, only: [:edit, :update]


  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    debugger
    @user = User.new(user_params)
    if @user.save
      flash[:noticed] = "Welcome to book review site #{@user.username}"
        redirect_to books_path
    else
      render 'new'
    end
  end

  def edit
  end

  def create
  end 

  private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
      if current_user != @review.user
        flash[:danger]= "you can perform this action only if you're the one who wrote this review!"
        redirect_to root_path
      end
    end

  end
