class SubsController < ApplicationController

  before_action :must_be_logged_in, only: [:new, :edit, :update]
  before_action :must_be_moderator, only: :edit

  def new
    render :new
  end

  def create
    @sub = Sub.new(title: user_params[:title], description: user_params[:description], moderator_id: current_user.id)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    render :show
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(user_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private

  def must_be_moderator
    @sub = Sub.find(params[:id])
    unless current_user.id == @sub.moderator_id
      flash.now[:errors] = ["Only moderators can edit this Sub!"]
      render :show
    end
  end

  def user_params
    params.require(:sub).permit(:title, :description)
  end

end
