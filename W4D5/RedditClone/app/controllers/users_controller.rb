class UsersController < ApplicationController

  before_action :must_be_logged_out

  def new
    render :new
  end

  def create
    @user = User.new(username: user_params[:username], password: user_params[:password])
    if @user.save
      login_user!(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
