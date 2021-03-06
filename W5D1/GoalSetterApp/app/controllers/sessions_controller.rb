class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(session_params[:username], session_params[:password])
    if @user
      login(@user)
      redirect_to users_url
    else
      flash[:errors] = ["No User found!"]
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end

  def session_params
    params.require(:user).permit(:username, :password)
  end

end
