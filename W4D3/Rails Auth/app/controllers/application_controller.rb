class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :login_user!

  def login_user!
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if @user
      session[:session_token] = @user.reset_session_token!
    end
  end

  def current_user
    @user = User.find_by(session_token: session[:session_token])
    return @user if @user
    nil
  end

  private

  def user_logged_in
    if current_user
      redirect_to cats_url
    else
      render :new
    end
  end
end
