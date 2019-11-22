class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method  :current_user, :logged_in?, :sortable, :is_Admin_user?

  def current_user
     User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
   !!current_user
  end

  def is_Admin_user?
    !!current_user && current_user.admin
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
    helpers.link_to title, :sort => column, :direction => direction
  end

  def require_user
    if ! logged_in?
      flash[:danger] = "to perform this action you mush log in!"
      redirect_to root_path
    end
  end

  def require_admin_user
    if !current_user.admin?
      flash[:danger]= "this action can be done only by admin role!"
        redirect_to root_path
    end
  end

end
