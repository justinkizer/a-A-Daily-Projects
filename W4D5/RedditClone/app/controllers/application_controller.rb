class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def login_user!(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end

  def logout_user!
    current_user.reset_session_token!
    @current_user = nil
    session[:session_token] = nil
  end

  def logged_in?
    !current_user.nil?
  end

  def must_be_logged_out
    redirect_to subs_url if logged_in?
  end

  def must_be_logged_in
    unless logged_in?
      flash[:errors] = ["You must be logged in to do that!"]
      redirect_to new_session_url
    end
  end

end
