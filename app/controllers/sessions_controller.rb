class SessionsController < ApplicationController

    def new
      @user = User.new
    end

    def create
      user = User.find_by(email: params[:session][:email].downcase)
      print user.username if user
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        flash[:success] = "you have successfully logged in #{user.username}"
        redirect_to user_path(user)
      else
        flash.now[:fail] = "there is a mistake in the credential you entered, try it again"
        render 'new'
      end

    end

    def destroy
      session[:user_id] = nil
      flash[:success] = "you have logged out"
      redirect_to root_path
    end

end
