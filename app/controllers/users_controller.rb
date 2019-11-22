class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:show, :index, :new, :create]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_admin_user, only: [:destroy]


  def show
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
    if @user.update(user_params)
      flash[:noticed] = "user is updated successfully"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:noticed] = "you're successfully signed up"
        redirect_to login_path()
    else
      render :new
    end
  end

  def destroy
    @username = @user.username
    @user.destroy
    flash[:noticed] = "user "+ @username +" is deleted successfully"
    redirect_to users_path
  end


  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
      if current_user != @user && !current_user.admin?
        flash[:danger]= "you can perform this action only if you're the one who wrote this review!"
        redirect_to root_path
      end
    end
  end
