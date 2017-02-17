class SessionsController < ApplicationController

  before_action :must_be_logged_out, except: :destroy

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    if @user
      login_user!(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = ["Username and/or password not found!"]
      render :new
    end
  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
