class UsersController < ApplicationController

  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      show_success
    else
      show_error
    end
  end

  def show
    @user = User.find(params[:id])
    show_success
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      show_success
    else
      show_error
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      show_success
    else
      show_error
    end
  end

  private
  def user_params
    params.require(:user).permit(:username)
  end

  def show_error
    render json: @user.errors.full_messages, status: :unprocessable_entity
  end

  def show_success
    render json: @user
  end
end
