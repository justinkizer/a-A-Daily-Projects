class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params[:email], user_params[:password])
    if @user
      login_user!(@user)
      render :show
    else
      flash.now[:errors] = ["User/Password Combination not found!"]
      render :new
    end
  end

  def destroy
    logout_user!
    flash.now[:errors] = ["You've been logged out; come back soon!"]
    render :new
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
