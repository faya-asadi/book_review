class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method  :current_user, :logged_in?, :sortable

  def current_user
     User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
   !!current_user
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
end
